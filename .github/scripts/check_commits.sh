#!/bin/bash
set -eu

target_branch_diff_commits=$(git rev-list HEAD ^origin/${GITHUB_BASE_REF})

while read -r commit_hash; do
    commit_message="$(git log --format=%B -n 1 ${commit_hash})"
    if [[ $branch =~ '\[[A-Z]{2,}-\d+\]']]; then
        echo "[PASS] ${commit_message}"
    else
        echo "[FAIL] ${commit_message}"
        exit 1;
    fi
done <<< "$target_branch_diff_commits"