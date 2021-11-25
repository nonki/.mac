#! /bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install node@14

brew link node@14 --force

brew tap kudobuilder/tap
brew install vim go thefuck rbenv pass keychain rg tmux java jenv python assh zsh gnupg pygments kind kubectl kustomize kubebuilder kuttl-cli jq

read -p 'Generate new key? [y/N]: ' shouldGenerateKey

shouldGenerateKey=${shouldGenerateKey:-"N"}

if [ $shouldGenerateKey == 'y' ]; then # failed
  ssh-keygen -t ed25519 -C "thomas.flack@skybettingandgaming.com"
fi

read -p 'Path to key [~/.ssh/id_ed25519]: ' keypathvar
keypathvar=${keypathvar:-"~/.ssh/id_ed25519"}

eval "$(ssh-agent -s)"

touch ~/.ssh/config

ssh-add -K $keypathvar

pbcopy < $keypathvar # need to be .pub

read -p 'Continue once uploaded key to Github [y]: ' contvar

mkdir -p ~/code/github.com/nonki

cd ~/code/github.com/nonki

git clone git@github.com:nonki/.vim.git

git clone git@github.com:nonki/.tmux.git

git clone git@github.com:nonki/.ssh.git

git clone git@github.com:nonki/.zsh.git

git clone git@github.com:nonki/.gitconfig.git

#/bin/bash -c "$(cat .vim/link.sh)"
#/bin/bash -c "$(cat .tmux/link.sh)"
#/bin/bash -c "$(cat .ssh/link.sh)"
#/bin/bash -c "$(cat .zsh/link.sh)"
# download another

# generate gpg key
# pass init "GPG KEY ID"

cd /tmp && go install golang.org/x/tools/gopls@latest

ssh-keyscan -t rsa stash.skybet.net >> ~/.ssh/known_hosts

mkdir -p ~/tmp/.ssh

ln -s ~/code/github.com/nonki/.tmux ~/.tmux
ln -s ~/code/github.com/nonki/.vim ~/.vim
ln -s ~/code/github.com/nonki/.zshenv ~/.zshenv
ln -s ~/code/github.com/nonki/.ssh/assh.yml ~/.ssh/assh.yml

~/.vim/install.sh

git config --global user.name "Thomas Flack"
git config --global user.email "thomas.flack@skybettingandgaming.com"
git config --global core.hooksPath ~/code/github.com/nonki/.gitconfig/hooks

/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # took me into seperate shell
