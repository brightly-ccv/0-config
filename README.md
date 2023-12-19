# Bootstrap config install

This script is for bootstrapping your configuration on fedora, post installation.

## Usage
``` bash
curl https://raw.githubusercontent.com/brightly-ccv/0-config/main/run > run; bash run
```

This is how you can modify it's behavior
```
Usage: ./run [ -t ] [ -h ] [ -g GITLAB_HOSTS ]
 -h This help message
 -t Do not use ssh when testing
 -g Takes a number to loop through setting up gitlab hosts
```
