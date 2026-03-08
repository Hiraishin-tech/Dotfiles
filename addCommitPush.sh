#!/bin/bash

git status
if [[ -z "$(git status --short)" ]]; then
    echo "No changes to commit and push"
    exit 1
fi

read -ep "Write a commit message: " message
if [[ -z "$message" ]]; then
    echo "You must write a message to the commit!!"
    exit 1
fi

git add .
git commit -m "$message"
git push
