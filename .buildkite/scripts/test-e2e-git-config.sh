#!/usr/bin/env bash

set -euo pipefail

echo "--- :git: Verifying git user.name is configured"

git_user_name=$(git config user.name)
expected_name="elastic-ci[bot]"

if [ "${git_user_name}" != "${expected_name}" ]; then
  echo "^^^ +++"
  echo "Error: git user.name is '${git_user_name}', expected '${expected_name}'"
  exit 1
fi

echo "git user.name is correctly set to: ${git_user_name}"

echo "--- :git: Verifying git user.email is configured"

git_user_email=$(git config user.email)
expected_email="elastic-ci[bot]@users.noreply.github.com"

if [ "${git_user_email}" != "${expected_email}" ]; then
  echo "^^^ +++"
  echo "Error: git user.email is '${git_user_email}', expected '${expected_email}'"
  exit 1
fi

echo "git user.email is correctly set to: ${git_user_email}"

echo ""
echo "E2E test passed! git config is correctly configured when configure-git-user is enabled."
