inspect_args
sudo yum install -y keepassxc git gh glab ansible ansible-core which gcc openssl-devel

if [ ! -d "0-config" ] ; then
	git clone https://github.com/brightly-ccv/0-config
fi

cd 0-config || exit

if [ -z "${args[--test]}" ]; then
	if [ ! -f "$private_ssh_key" ]; then
		mkdir -p -m 700 ~/.ssh
		ssh-keygen -t ed25519 -f "$private_ssh_key"
		eval "$(ssh-agent -s)"
		ssh-add
	fi
	gh auth login -h github.com -p ssh -w -s admin:public_key
	counter=0
	while [ $counter -lt "${args[--gitlab_hosts]}" ]; do
		glab auth login -h "$host"
		glab config set gitlab_host "$host"
		glab ssh-key add -t "main driver" "$public_ssh_key"
		((counter++))
	done
fi

## Install rustup
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
## Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/bin"
## Install git repo manager
. "$HOME/.cargo/env"
cargo +nightly install git-repo-manager

## Initialize configs for your system
if [ -z "${args[--test]}" ]; then
	eval "$(ssh-agent -s)"
	ssh-add
	chezmoi init --apply git@github.com:brightly-ccv/dotfiles.git
	grm repos sync config --config ~/.config/grm/config.toml
fi
echo "run 'source $HOME/.cargo/env' if you want to enable rust tools in this session"
