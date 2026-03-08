#!/bin/bash

git status
git add .
read -p "Write a commit message: " message
git commit -m "$message"
git push
