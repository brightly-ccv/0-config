# run

Bootstrap Config

| Attributes       | &nbsp;
|------------------|-------------
| Version:         | 0.1.0

## Usage

```bash
run [OPTIONS]
```

## Environment Variables

#### *PRIVATE_SSH_KEY*

Set private ssh key path

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | $HOME/.ssh/id_ed25519

#### *PUBLIC_SSH_KEY*

Set public ssh key path

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | $HOME/.ssh/id_ed25519.pub

## Options

#### *--test, -t*

Testing skips ssh key generation

#### *--gitlab_hosts, -g GITLAB_HOSTS*

Gitlab hosts to log in


