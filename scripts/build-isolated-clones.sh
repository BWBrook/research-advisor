#!/usr/bin/env bash
set -euo pipefail

# Build a curated, single-commit, history-free baseline repository for Workflow A or B
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
#     [--workflow A|B] \
#     [--resources-dir /path/to/shared-resources] \
#     [--dest-root "$HOME"] \
#     [--baseline-only | --clones-only]

SOURCE_REPO=""
MANIFEST=""
INPUT_MD=""
BASELINE_DIR=""
PROJECT=""
WORKFLOW="A"
RESOURCES_DIR=""
DEST_ROOT="$HOME"
MODE="both"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source-repo) SOURCE_REPO="$2"; shift 2 ;;
    --manifest) MANIFEST="$2"; shift 2 ;;
    --input-md) INPUT_MD="$2"; shift 2 ;;
    --baseline-dir) BASELINE_DIR="$2"; shift 2 ;;
    --project) PROJECT="$2"; shift 2 ;;
    --workflow) WORKFLOW="$2"; shift 2 ;;
    --resources-dir) RESOURCES_DIR="$2"; shift 2 ;;
    --dest-root) DEST_ROOT="$2"; shift 2 ;;
    --baseline-only) MODE="baseline"; shift ;;
    --clones-only) MODE="clones"; shift ;;
    -h|--help)
      sed -n '3,21p' "$0"
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 2 ;;
  esac
done

[[ -n "$BASELINE_DIR" && -n "$PROJECT" ]] || { echo "Missing --baseline-dir or --project" >&2; exit 2; }
[[ "$WORKFLOW" == "A" || "$WORKFLOW" == "B" ]] || { echo "Invalid --workflow (expected A or B): $WORKFLOW" >&2; exit 2; }

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

  if [[ "$WORKFLOW" == "A" ]]; then
    cat > "$BASELINE_DIR/.gitignore" <<'EOF'
/output/
/resources/
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
- If \`resources/\` is present, treat its files as read-only reference material (e.g. paper PDFs or frozen data); never modify or commit them.
EOF

    cat > "$BASELINE_DIR/CLAUDE.md" <<'EOF'
# Experiment A workspace instructions

Read `AGENTS.md` and `INPUT.md` before beginning. Obey all isolation boundaries strictly (no Correspondence Board, no peer workspaces, no parent repository inspection, no prior project memory).
EOF

    cat > "$BASELINE_DIR/GEMINI.md" <<'EOF'
# Experiment A workspace instructions

Read `AGENTS.md` and `INPUT.md` before beginning. Obey all isolation boundaries strictly (no Correspondence Board, no peer workspaces, no parent repository inspection, no prior project memory).
EOF
  else
    cat > "$BASELINE_DIR/.gitignore" <<'EOF'
/output/
/resources/
.DS_Store
renv/library/
renv/staging/
.Rhistory
.RData
.Rproj.user/
EOF

    cat > "$BASELINE_DIR/AGENTS.md" <<EOF
# Isolated Workflow B workspace — $PROJECT

This is a curated, single-commit, remote-free baseline exported from \`$PROJECT@$short_sha\` ($commit) for independent original research and project completion.

## Strict boundaries

- Read \`INPUT.md\` and your active assignment in \`output/\` before beginning.
- Follow the active round's scope strictly: during project conception (B1), do not edit repository files, install environments, or run code/benchmarks—write only your brief to \`output/\`.
- Work completely independently. Do not read or consult peer workspaces (\`~/codex/\`, \`~/claude/\`, \`~/gemini/\`), the adviser repository (\`~/work/research-advisor\`), or unrelated local repositories.
- **Do not query or post to any Correspondence Board** (via MCP or otherwise), read prior chat transcripts, or rely on cross-workspace memory about this project.
- Do not add Git remotes or push anywhere during independent rounds.
- If \`resources/\` is present, treat its files as read-only reference material (e.g. paper PDFs or frozen datasets); never modify or commit them.
EOF

    cat > "$BASELINE_DIR/CLAUDE.md" <<'EOF'
# Workflow B workspace instructions

Read `AGENTS.md`, `INPUT.md`, and your active assignment in `output/` before beginning. Obey all isolation boundaries strictly (no Correspondence Board, no peer workspaces, no adviser repository inspection, no cross-workspace memory, no Git remotes or pushes).
EOF

    cat > "$BASELINE_DIR/GEMINI.md" <<'EOF'
# Workflow B workspace instructions

Read `AGENTS.md`, `INPUT.md`, and your active assignment in `output/` before beginning. Obey all isolation boundaries strictly (no Correspondence Board, no peer workspaces, no adviser repository inspection, no cross-workspace memory, no Git remotes or pushes).
EOF
  fi

  git -C "$BASELINE_DIR" init -q -b main
  git -C "$BASELINE_DIR" add -A
  git -C "$BASELINE_DIR" -c commit.gpgsign=false commit -q \
    -m "Curated Workflow $WORKFLOW baseline from $PROJECT@$short_sha"

  echo "Built curated baseline ($count manifest files) at $BASELINE_DIR"
  echo "Baseline commit: $(git -C "$BASELINE_DIR" rev-parse HEAD) (exported from $commit)"
}

build_clones() {
  [[ -d "$BASELINE_DIR/.git" ]] || { echo "Missing baseline git repo: $BASELINE_DIR" >&2; exit 1; }
  if [[ -n "$RESOURCES_DIR" ]]; then
    [[ -d "$RESOURCES_DIR" ]] || { echo "Missing resources dir: $RESOURCES_DIR" >&2; exit 1; }
    find "$RESOURCES_DIR" -type f -exec chmod a-w {} +
    echo "Locked shared resource files read-only (chmod a-w): $RESOURCES_DIR"
  fi
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
    if [[ -n "$RESOURCES_DIR" ]]; then
      mkdir -p "$target/resources"
      if ! cp -al "$RESOURCES_DIR/." "$target/resources/" 2>/dev/null; then
        echo "Note: hardlink copy (cp -al) unavailable for $target/resources; falling back to standard copy" >&2
        cp -R -p "$RESOURCES_DIR/." "$target/resources/"
      fi
    fi
    echo "Created isolated remote-free clone: $target"
  done
}

case "$MODE" in
  baseline) build_baseline ;;
  clones) build_clones ;;
  both) build_baseline; build_clones ;;
esac
