#!/bin/bash
set -eu

regex="\[[a-zA-Z0-9,\.\_\-]+-[0-9]+\]"

target_branch_diff_commits=$(git rev-list HEAD ^origin/prod/v3)

while read -r commit_hash; do
    commit_message="$(git log --format=%B -n 1 ${commit_hash})"
    if [[ $commit_message =~ $regex ]]; then
        echo "[PASS] ${commit_message}"
    else
        echo "[FAIL] ${commit_message}"
        exit 1
    fi
done <<< "$target_branch_diff_commits"