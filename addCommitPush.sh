#!/bin/bash

git status
read -ep "Write a commit message: " message
if [[ -z "$message" ]]; then
    echo "You must write a message to the commit!!"
    exit 1
fi

git add .
git commit -m "$message"
git push
