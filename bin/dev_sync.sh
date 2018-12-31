#!/bin/bash

root="$(git rev-parse --show-toplevel)"

# shellcheck disable=SC1090,SC1091
source "$root/.env"

rsync -a --delete "$ACF_JSON_TRACKED_DIR" "$ACF_JSON_MU_PLUGIN_DIR"
