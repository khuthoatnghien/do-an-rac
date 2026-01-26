#!/usr/bin/env bash
set -e

BUILD_DIR="book"
TARGET_BRANCH="gh-pages"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "Build mdBook..."
mdbook build

echo "Switch to $TARGET_BRANCH..."
git checkout $TARGET_BRANCH

echo "Xoá nội dung cũ..."
git rm -rf .

echo "Copy nội dung mới..."
cp -r $BUILD_DIR/* .

echo "Commit..."
git add .
git commit -m "Deploy mdBook: $(date '+%Y-%m-%d %H:%M:%S')"

echo "Push..."
git push origin $TARGET_BRANCH

echo "Quay lại branch ban đầu..."
git checkout $CURRENT_BRANCH

echo "Deploy hoàn tất."
