#!/bin/bash

# bin/new_release.sh
# Creates a new release of this plugin on GitHub.

release_branch="master"

root_dir() {
  git rev-parse --show-toplevel
}

tag() {
  jq -r ".version" "$(root_dir)/composer.json"
}

current_branch() {
  git symbolic-ref --short -q HEAD
}

on_release_branch() {
  if [ ! "$(current_branch)" == "$release_branch" ]; then
    return 1
  fi
}

ensure_on_release_branch() {
  if ! on_release_branch; then
    local msg="This script can only run from the release branch.\n\n"
    msg+="release branch: $release_branch\n"
    msg+="current branch: $(current_branch)"

    echo -e "$msg"
    exit 1
  fi
}

local_sha() {
  git rev-parse "$(current_branch)"
}

remote_sha() {
  git rev-parse "origin/$(current_branch)"
}

up_to_date() {
  git fetch --all --quiet

  if [ ! "$(local_sha)" == "$(remote_sha)" ]; then
    return 1
  fi
}

clean_working_dir() {
  if [ ! -z "$(git status --porcelain)" ]; then
    return 1
  fi
}

check_if_up_to_date() {
  if ! up_to_date || ! clean_working_dir; then
    echo -e "Current branch is out of date - push/pull before retrying."
    exit 1
  fi
}

tag_already_exists() {
  git show-ref --tags --quiet --verify -- "refs/tags/$(tag)"
}

check_if_tag_exists() {
  if tag_already_exists; then
    echo -e "A tag already exists for version $(tag)."
    exit 1
  fi
}

regenerate_autoloader() {
  composer dump-autoload -a -q

  if ! clean_working_dir; then
    git add -A
    git commit -m "Regenerate the autoloader"
    git push origin "$release_branch" > /dev/null 2>&1
  fi
}

create_release() {
  git tag -a "$(tag)" -m "$(tag)"
  git push origin "$release_branch" --tags > /dev/null 2>&1
}

ensure_on_release_branch
check_if_tag_exists
check_if_up_to_date
regenerate_autoloader
check_if_up_to_date
create_release && echo "Released v$(tag)."
