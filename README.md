# Configure the ephemeral GitHub token provided by the Vault Plugin

[![usages](https://img.shields.io/badge/usages-white?logo=buildkite&logoColor=blue)](https://github.com/search?q=elastic%2Fvault-github-token+%28path%3A.buildkite%29&type=code)

## Usage

```yml
steps:
  - command: <...>
    plugins:
      - elastic/vault-github-token#v0.1.0:
```

## Configuration

### `configure-git-user` (optional, boolean)

When set to `true`, configures the git `user.name` and `user.email` in the current workspace to default CI bot values:

- `user.name`: `elastic-ci[bot]`
- `user.email`: `elastic-ci[bot]@users.noreply.github.com`

Defaults to `false` (opt-in).

```yml
steps:
  - command: <...>
    plugins:
      - elastic/vault-github-token#v0.1.0:
          configure-git-user: true
```
