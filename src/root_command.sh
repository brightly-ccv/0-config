echo "# this file is located in 'src/root_command.sh'"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args
sudo yum install -y keepassxc git gh glab ansible ansible-core which gcc openssl-devel
git clone https://github.com/brightly-ccv/0-config
cd 0-config

if [ $test == 'true' ];
	then
	if [ ! -f "$ssh_priv_key" ];
	then
		mkdir -p -m 700 ~/.ssh
		ssh-keygen -t ed25519 -f "$ssh_priv_key"
		eval `ssh-agent -s`; ssh-add
	fi
	gh auth login -h github.com -p ssh -w -s admin:public_key
	for amount in {1..$gitlab_hosts}
	do
		glab auth login -h $host
        	glab config set gitlab_host "$host"
        	glab ssh-key add -t "main driver" "$ssh_pub_key"
	done
fi

## Install rustup
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
## Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/bin
## Install git repo manager
. "$HOME/.cargo/env"
cargo +nightly install git-repo-manager

## Initialize configs for your system
if [ $use_ssh == 'true' ]; then
	eval `ssh-agent -s`; ssh-add
	chezmoi init --apply git@github.com:brightly-ccv/dotfiles.git
	grm repos sync config --config ~/.config/grm/config.toml
fi
echo "run 'source $HOME/.cargo/env' if you want to enable rust tools in this session"
