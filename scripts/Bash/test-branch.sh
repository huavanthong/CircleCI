#!/bin/bash

tag_branch="htv3hc/feat/tag-version-0.0.2"

pr_exists=$(gh pr list --state open | grep "Auto-generated PR")
# Github CLI for pull request.
if [ -z $pr_exists ]; then
    # Pull request chưa tồn tại, tạo mới
    echo "Pull request not found. Creating a new one..."
    gh pr create \
    --base master --head $tag_branch \
    --title "Auto-generated PR" \
    --body "This PR was automatically generated by GitHub Actions." \
    --assignee huavanthong \
    --reviewer huavanthong
else
    # Pull request đã tồn tại, thông báo và không thực hiện thêm hành động
    echo "Pull request already exists. Skipping..."
fi