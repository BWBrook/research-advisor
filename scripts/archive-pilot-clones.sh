#!/usr/bin/env bash
set -euo pipefail

# Package temporary multi-model pilot workspaces into a single compact zip archive
# (preserving full .git history, tracked code/docs, and Markdown briefs/reports while
# stripping ALL generated build, simulation, cache and check artifacts), verify archive
# integrity, and optionally remove the temporary workspaces.
#
# Usage:
#   scripts/archive-pilot-clones.sh \
#     --project openpva \
#     --output projects/openpva/work/openpva-pilot-archive.zip \
#     --workspace codex="$HOME/codex/openpva" \
#     --workspace claude="$HOME/claude/openpva" \
#     --workspace gemini="$HOME/gemini/openpva" \
#     [--workspace integration="$HOME/codex/openpva-2.0"] \
#     [--workspace audit="$HOME/claude/openpva-audit"] \
#     [--adviser-work projects/openpva/work] \
#     [--delete-sources]

PROJECT=""
OUTPUT=""
ADVISER_WORK=""
DELETE_SOURCES=0
WORKSPACES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2 ;;
    --output) OUTPUT="$2"; shift 2 ;;
    --workspace) WORKSPACES+=("$2"); shift 2 ;;
    --adviser-work) ADVISER_WORK="$2"; shift 2 ;;
    --delete-sources) DELETE_SOURCES=1; shift ;;
    -h|--help)
      sed -n '3,20p' "$0"
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

[[ -n "$PROJECT" && -n "$OUTPUT" && ${#WORKSPACES[@]} -gt 0 ]] || {
  echo "Required: --project, --output, and at least one --workspace label=path" >&2
  exit 2
}

if [[ -e "$OUTPUT" ]]; then
  echo "Refusing to overwrite existing archive: $OUTPUT" >&2
  exit 1
fi

command -v zip >/dev/null 2>&1 || { echo "Missing required tool: zip" >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "Missing required tool: unzip" >&2; exit 1; }

OUT_ABS=$(python3 -c 'import os, sys; print(os.path.abspath(sys.argv[1]))' "$OUTPUT")
mkdir -p "$(dirname "$OUT_ABS")"

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
ROOT="$STAGE/${PROJECT}-pilot-archive"
mkdir -p "$ROOT"

MANIFEST="$ROOT/ARCHIVE-MANIFEST.txt"
{
  echo "Project: $PROJECT"
  echo "Archived UTC: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "Contents: full .git history, tracked HEAD source/docs, and Markdown briefs/reports (generated artifacts stripped)"
  echo ""
} > "$MANIFEST"

DELETABLE_DIRS=()

for entry in "${WORKSPACES[@]}"; do
  label="${entry%%=*}"
  src="${entry#*=}"
  if [[ -z "$label" || -z "$src" || "$label" == "$entry" ]]; then
    echo "Invalid --workspace format (expected label=path): $entry" >&2
    exit 2
  fi
  [[ -d "$src/.git" ]] || { echo "Not a git repository: $src" >&2; exit 1; }

  dest="$ROOT/$label"
  mkdir -p "$dest"

  # Preserve complete git object database and refs
  cp -a "$src/.git" "$dest/.git"
  # Extract exact tracked HEAD tree (excludes all untracked build/sim/check clutter)
  git -C "$src" archive HEAD | tar -x -C "$dest"

  # Keep top-level Markdown reports/assignments/charters inside output/
  md_count=0
  if [[ -d "$src/output" ]]; then
    mkdir -p "$dest/output"
    while IFS= read -r -d '' f; do
      cp -p "$f" "$dest/output/$(basename "$f")"
      md_count=$((md_count + 1))
    done < <(find "$src/output" -maxdepth 1 -type f -name '*.md' -print0 | sort -z)
    if [[ "$md_count" -eq 0 ]]; then
      rmdir "$dest/output"
    fi
  fi

  head_sha=$(git -C "$src" rev-parse HEAD)
  branch=$(git -C "$src" rev-parse --abbrev-ref HEAD)
  echo "Workspace: $label | branch: $branch | HEAD: $head_sha | output/*.md: $md_count" >> "$MANIFEST"
  DELETABLE_DIRS+=("$src")
done

if [[ -n "$ADVISER_WORK" ]]; then
  [[ -d "$ADVISER_WORK" ]] || { echo "Missing --adviser-work dir: $ADVISER_WORK" >&2; exit 1; }
  adv_dest="$ROOT/adviser-records"
  mkdir -p "$adv_dest"
  # Copy top-level Markdown/manifest records and frozen-* Markdown snapshots only
  while IFS= read -r -d '' f; do
    cp -p "$f" "$adv_dest/$(basename "$f")"
  done < <(find "$ADVISER_WORK" -maxdepth 1 -type f \( -name '*.md' -o -name 'manifest.txt' \) -print0 | sort -z)
  while IFS= read -r -d '' d; do
    base=$(basename "$d")
    mkdir -p "$adv_dest/$base"
    while IFS= read -r -d '' f; do
      rel="${f#"$d"/}"
      mkdir -p "$adv_dest/$base/$(dirname "$rel")"
      cp -p "$f" "$adv_dest/$base/$rel"
    done < <(find "$d" -type f -name '*.md' -print0 | sort -z)
  done < <(find "$ADVISER_WORK" -maxdepth 1 -type d -name 'frozen-*' -print0 | sort -z)
  echo "Adviser records included from: $(basename "$ADVISER_WORK") (top-level .md, manifest.txt, frozen-*/*.md)" >> "$MANIFEST"
fi

(cd "$STAGE" && zip -rq9 "$OUT_ABS" "${PROJECT}-pilot-archive")
unzip -tq "$OUT_ABS"

echo "Archive created and verified: $OUT_ABS ($(du -h "$OUT_ABS" | cut -f1))"

if [[ "$DELETE_SOURCES" -eq 1 ]]; then
  for src in "${DELETABLE_DIRS[@]}"; do
    rm -rf "$src"
    echo "Removed temporary workspace: $src"
  done
fi
