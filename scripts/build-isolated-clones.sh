#!/usr/bin/env bash
set -euo pipefail

# Build a curated, single-commit, history-free baseline repository for Experiment A
# and optionally clone it into isolated, remote-free scientist workspaces:
#   <dest-root>/codex/<project>
#   <dest-root>/claude/<project>
#   <dest-root>/gemini/<project>
#
# Usage:
#   scripts/build-isolated-clones.sh \
#     --source-repo /path/to/source \
#     --manifest /path/to/manifest.txt \
#     --input-md /path/to/INPUT.md \
#     --baseline-dir /path/to/baseline \
#     --project rc-dates \
#     [--dest-root "$HOME"] \
#     [--baseline-only | --clones-only]

SOURCE_REPO=""
MANIFEST=""
INPUT_MD=""
BASELINE_DIR=""
PROJECT=""
DEST_ROOT="$HOME"
MODE="both"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source-repo) SOURCE_REPO="$2"; shift 2 ;;
    --manifest) MANIFEST="$2"; shift 2 ;;
    --input-md) INPUT_MD="$2"; shift 2 ;;
    --baseline-dir) BASELINE_DIR="$2"; shift 2 ;;
    --project) PROJECT="$2"; shift 2 ;;
    --dest-root) DEST_ROOT="$2"; shift 2 ;;
    --baseline-only) MODE="baseline"; shift ;;
    --clones-only) MODE="clones"; shift ;;
    -h|--help)
      sed -n '3,19p' "$0"
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

[[ -n "$BASELINE_DIR" && -n "$PROJECT" ]] || { echo "Missing --baseline-dir or --project" >&2; exit 2; }

build_baseline() {
  [[ -d "$SOURCE_REPO/.git" ]] || { echo "Not a git repo: $SOURCE_REPO" >&2; exit 1; }
  [[ -f "$MANIFEST" ]] || { echo "Missing manifest: $MANIFEST" >&2; exit 1; }
  [[ -f "$INPUT_MD" ]] || { echo "Missing INPUT.md: $INPUT_MD" >&2; exit 1; }
  if [[ -e "$BASELINE_DIR" ]]; then
    echo "Refusing to overwrite existing baseline: $BASELINE_DIR" >&2
    exit 1
  fi

  local commit short_sha
  commit=$(git -C "$SOURCE_REPO" rev-parse HEAD)
  short_sha=$(git -C "$SOURCE_REPO" rev-parse --short HEAD)

  mkdir -p "$BASELINE_DIR"

  local count=0
  while IFS= read -r raw || [[ -n "$raw" ]]; do
    local rel
    rel=$(printf '%s' "$raw" | sed 's/#.*$//; s/^[[:space:]]*//; s/[[:space:]]*$//')
    [[ -z "$rel" ]] && continue
    local src="$SOURCE_REPO/$rel"
    [[ -f "$src" ]] || { echo "Manifest file missing in source repo: $rel" >&2; exit 1; }
    mkdir -p "$BASELINE_DIR/$(dirname "$rel")"
    cp -p "$src" "$BASELINE_DIR/$rel"
    count=$((count + 1))

    if [[ "$rel" == manuscript/figures/*.pdf ]] && command -v pdftoppm >/dev/null 2>&1; then
      mkdir -p "$BASELINE_DIR/manuscript/figures/preview"
      local stem
      stem=$(basename "$rel" .pdf)
      pdftoppm -png -r 150 -singlefile "$src" "$BASELINE_DIR/manuscript/figures/preview/$stem"
    fi
  done < "$MANIFEST"

  cp "$INPUT_MD" "$BASELINE_DIR/INPUT.md"

  cat > "$BASELINE_DIR/.gitignore" <<'EOF'
/output/
.DS_Store
EOF

  cat > "$BASELINE_DIR/AGENTS.md" <<EOF
# Isolated Experiment A workspace — $PROJECT

This is a curated, single-commit baseline exported from \`$PROJECT@$short_sha\` ($commit) for independent editorial reconstruction.

## Strict boundaries

- Read \`INPUT.md\` first for scope, allowed files, reading order and target venue constraints.
- Treat the science, analyses and evidence as settled. Do not run analyses, modify data/code or broaden scope.
- Work independently. Do not read or consult other scientists' workspaces, branches or reports.
- **Do not query the Correspondence Board** (via MCP or otherwise), read prior chat transcripts, inspect the parent repository, or rely on prior project memory about this study.
- During reconnaissance (A1), do not edit repository files; write only your assessment to \`output/\`.
EOF

  cat > "$BASELINE_DIR/CLAUDE.md" <<'EOF'
# Experiment A workspace instructions

Read `AGENTS.md` and `INPUT.md` before beginning. Obey all isolation boundaries strictly (no Correspondence Board, no peer workspaces, no parent repository inspection, no prior project memory).
EOF

  cat > "$BASELINE_DIR/GEMINI.md" <<'EOF'
# Experiment A workspace instructions

Read `AGENTS.md` and `INPUT.md` before beginning. Obey all isolation boundaries strictly (no Correspondence Board, no peer workspaces, no parent repository inspection, no prior project memory).
EOF

  git -C "$BASELINE_DIR" init -q -b main
  git -C "$BASELINE_DIR" add -A
  git -C "$BASELINE_DIR" -c commit.gpgsign=false commit -q \
    -m "Curated Experiment A baseline from $PROJECT@$short_sha"

  echo "Built curated baseline ($count manifest files) at $BASELINE_DIR"
  echo "Baseline commit: $(git -C "$BASELINE_DIR" rev-parse HEAD) (exported from $commit)"
}

build_clones() {
  [[ -d "$BASELINE_DIR/.git" ]] || { echo "Missing baseline git repo: $BASELINE_DIR" >&2; exit 1; }
  for family in codex claude gemini; do
    local target="$DEST_ROOT/$family/$PROJECT"
    if [[ -e "$target" ]]; then
      echo "Refusing to overwrite existing workspace: $target" >&2
      exit 1
    fi
  done

  for family in codex claude gemini; do
    local target="$DEST_ROOT/$family/$PROJECT"
    mkdir -p "$DEST_ROOT/$family"
    git clone -q "$BASELINE_DIR" "$target"
    git -C "$target" remote remove origin
    mkdir -p "$target/output"
    echo "Created isolated remote-free clone: $target"
  done
}

case "$MODE" in
  baseline) build_baseline ;;
  clones) build_clones ;;
  both) build_baseline; build_clones ;;
esac
