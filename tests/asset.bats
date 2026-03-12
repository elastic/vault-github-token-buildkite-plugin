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

@test "configure-git-user sets git user name and email" {
    # arrange
    export BUILDKITE_PLUGIN_VAULT_GITHUB_TOKEN_CONFIGURE_GIT_USER="true"
    stub buildkite-agent \
        'echo "mock-token"'
    stub git \
        "config user.email 'elastic-ci[bot]@users.noreply.github.com' : echo 'set email'" \
        "config user.name 'elastic-ci[bot]' : echo 'set name'"

    # act
    run "$PWD/hooks/pre-command"

    # assert
    assert_success
    unstub git

    unset BUILDKITE_PLUGIN_VAULT_GITHUB_TOKEN_CONFIGURE_GIT_USER
}

@test "configure-git-user does not set git config by default" {
    # arrange
    stub buildkite-agent \
        'echo "mock-token"'

    # act
    run "$PWD/hooks/pre-command"

    # assert
    assert_success
}
