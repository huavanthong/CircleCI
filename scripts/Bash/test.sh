#!/bin/bash

tag_branch="htv3hc/feat/tag-version-0.0.2"
echo $tag_branch > tag_branch.txt

if [ -n "$(git ls-remote --heads origin $tag_branch)" ]; then
    git checkout $tag_branch
    git rebase master
else
    git checkout -b $tag_branch
fi

# git branch -a 



# Example 2:
# python hello.py  2>&1 | tee output.txt
# exit_code=${PIPESTATUS[0]}

# echo $exit_code

# if [ $exit_code -eq 127 ]; then
#     echo "Error: An error occurred in your_script.py."
#     # Thực hiện các hành động bổ sung ở đây
#     exit 1
# fi
