#!/usr/bin/env bats

load "$BATS_PLUGIN_PATH/load.bash"

export VAULT_GITHUB_TOKEN="mock-token"

@test "get token" {
    # arrange
    stub buildkite-agent \
        'echo "mock-token"'

    # act
    run "$PWD/hooks/pre-command"

    # assert
	assert_success

    env | grep "GITHUB_TOKEN" | grep -q "mock-token"
    [ $? -eq 0 ]
}

@test "failure to get token" {
    # arrange
    unset VAULT_GITHUB_TOKEN

    # act
    run "$PWD/hooks/pre-command"

    # assert
	assert_failure
    assert_output --partial "VAULT_GITHUB_TOKEN: unbound variable"
}
