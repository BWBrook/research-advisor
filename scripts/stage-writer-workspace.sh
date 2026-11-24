#!/usr/bin/env bash
set -euo pipefail

# Stage an isolated, remote-free primary-writer workspace at:
#   <dest-root>/writer/<project>
# cloned from a curated baseline, with frozen scientist drafts and adviser
# synthesis copied into a gitignored, read-only (chmod a-w) grist/ directory.
#
# Usage:
#   scripts/stage-writer-workspace.sh \
#     --baseline-dir /path/to/curated-baseline \
#     --project <slug> \
#     --assignment /path/to/writer-prompt.md \
#     [--synthesis /path/to/adviser-synthesis.md] \
#     [--grist-round A2] \
#     [--scientists-root "$HOME"] \
#     [--resources-dir /path/to/shared-resources] \
#     [--dest-root "$HOME"]

BASELINE_DIR=""
PROJECT=""
ASSIGNMENT=""
SYNTHESIS=""
GRIST_ROUND="A2"
SCIENTISTS_ROOT="$HOME"
RESOURCES_DIR=""
DEST_ROOT="$HOME"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --baseline-dir) BASELINE_DIR="$2"; shift 2 ;;
    --project) PROJECT="$2"; shift 2 ;;
    --assignment) ASSIGNMENT="$2"; shift 2 ;;
    --synthesis) SYNTHESIS="$2"; shift 2 ;;
    --grist-round) GRIST_ROUND="$2"; shift 2 ;;
    --scientists-root) SCIENTISTS_ROOT="$2"; shift 2 ;;
    --resources-dir) RESOURCES_DIR="$2"; shift 2 ;;
    --dest-root) DEST_ROOT="$2"; shift 2 ;;
    -h|--help)
      sed -n '3,19p' "$0"
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

[[ -n "$BASELINE_DIR" && -n "$PROJECT" && -n "$ASSIGNMENT" ]] || {
  echo "Missing --baseline-dir, --project or --assignment" >&2
  exit 2
}
[[ -d "$BASELINE_DIR/.git" ]] || { echo "Missing baseline git repo: $BASELINE_DIR" >&2; exit 1; }
[[ -f "$ASSIGNMENT" ]] || { echo "Missing assignment file: $ASSIGNMENT" >&2; exit 1; }
if [[ -n "$SYNTHESIS" ]]; then
  [[ -f "$SYNTHESIS" ]] || { echo "Missing synthesis file: $SYNTHESIS" >&2; exit 1; }
fi
if [[ -n "$RESOURCES_DIR" ]]; then
  [[ -d "$RESOURCES_DIR" ]] || { echo "Missing resources dir: $RESOURCES_DIR" >&2; exit 1; }
fi

DEST="$DEST_ROOT/writer/$PROJECT"
if [[ -e "$DEST" ]]; then
  echo "Refusing to overwrite existing writer workspace: $DEST" >&2
  exit 1
fi

mkdir -p "$DEST_ROOT/writer"
git clone -q "$BASELINE_DIR" "$DEST"
git -C "$DEST" remote remove origin

cat > "$DEST/.gitignore" <<'EOF'
/output/
/grist/
/resources/
.DS_Store
EOF

cat > "$DEST/AGENTS.md" <<EOF
# Primary Writer workspace — $PROJECT

You are the fresh primary writer working directly with the lead scientist to compose the final unified manuscript (\`output/FINAL-main.md\`, \`output/FINAL-figures.md\`, \`output/FINAL-coverage.md\`) from the curated baseline and the frozen scientist grist in \`grist/\`.

## Read first

1. \`output/ASSIGNMENT-WRITE.md\` (your full brief, bounds and editorial authority)
2. \`INPUT.md\`, primary figures/tables, claims ledger, interpretation contract and primary summary data
3. \`grist/\` (the adviser's verified audit synthesis and frozen scientist drafts)

## Strict boundaries

- Compose completely fresh in one unified voice; never patchwork-copy paragraphs across scientist drafts.
- **Do not query any Correspondence Board** (via MCP or otherwise), inspect the parent scientific repository, read \`git log\`, or rely on prior project memory.
- Do not edit source baseline files or files under \`grist/\` or \`resources/\`. Write all deliverables inside \`output/\`.
EOF

cat > "$DEST/GEMINI.md" <<'EOF'
# Primary Writer entry point

Read `AGENTS.md` and `output/ASSIGNMENT-WRITE.md` before beginning.
EOF

cat > "$DEST/CLAUDE.md" <<'EOF'
# Primary Writer entry point

Read `AGENTS.md` and `output/ASSIGNMENT-WRITE.md` before beginning.
EOF

git -C "$DEST" add .gitignore AGENTS.md GEMINI.md CLAUDE.md
git -C "$DEST" -c commit.gpgsign=false commit -q -m "Configure isolated primary-writer workspace for $PROJECT"

mkdir -p "$DEST/output" "$DEST/grist"
cp "$ASSIGNMENT" "$DEST/output/ASSIGNMENT-WRITE.md"

if [[ -n "$SYNTHESIS" ]]; then
  cp "$SYNTHESIS" "$DEST/grist/$(basename "$SYNTHESIS")"
fi

copied_grist=0
for fam in codex claude gemini; do
  src_out="$SCIENTISTS_ROOT/$fam/$PROJECT/output"
  if [[ -d "$src_out" ]]; then
    shopt -s nullglob
    matches=("$src_out/${GRIST_ROUND}"-*.md)
    shopt -u nullglob
    if [[ ${#matches[@]} -gt 0 ]]; then
      mkdir -p "$DEST/grist/$fam"
      for f in "${matches[@]}"; do
        cp "$f" "$DEST/grist/$fam/"
        copied_grist=$((copied_grist + 1))
      done
    fi
  fi
done

find "$DEST/grist" -type f -exec chmod a-w {} +

if [[ -n "$RESOURCES_DIR" ]]; then
  find "$RESOURCES_DIR" -type f -exec chmod a-w {} +
  mkdir -p "$DEST/resources"
  if ! cp -al "$RESOURCES_DIR/." "$DEST/resources/" 2>/dev/null; then
    echo "Note: hardlink copy (cp -al) unavailable for $DEST/resources; falling back to standard copy" >&2
    cp -R -p "$RESOURCES_DIR/." "$DEST/resources/"
  fi
fi

echo "Staged isolated primary-writer workspace: $DEST (copied $copied_grist $GRIST_ROUND scientist files into read-only grist/)"
