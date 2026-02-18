#!/usr/bin/env bash

set -euo pipefail

echo "--- :github: Verifying GITHUB_TOKEN is set"

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "^^^ +++"
  echo "Error: GITHUB_TOKEN is not set. The plugin did not export the token."
  exit 1
fi

echo "GITHUB_TOKEN is set"

echo "--- :github: Verifying GITHUB_TOKEN is valid"

response=$(curl -sS --fail-with-body \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/rate_limit") || {
    echo "^^^ +++"
    echo "Failed to call GitHub API. Token may be invalid or expired."
    exit 1
  }

remaining=$(echo "${response}" | jq -r '.rate.remaining')
echo "GitHub API responded successfully. Remaining rate limit: ${remaining}"

echo ""
echo "E2E test passed! GITHUB_TOKEN is valid."
