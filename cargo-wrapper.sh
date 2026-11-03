#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [[ -f "$SCRIPT_DIR/env.sh" ]]; then
    source "$SCRIPT_DIR/env.sh"
fi

args=()
profile_specified=0
for arg in "$@"; do
    case "$arg" in
        --no-r2r|--no-ros2)
            printf 'ROS 2 is opt-in in this project and is disabled by default.\n'
            ;;
        --release|--debug|--profile=*)
            profile_specified=1
            args+=("$arg")
            ;;
        *)
            args+=("$arg")
            ;;
    esac
done

if (( profile_specified == 0 )); then
    args+=(--release)
fi

printf 'Running: cargo'
printf ' %q' "${args[@]}"
printf '\n'
cargo "${args[@]}"
