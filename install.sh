#! /bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install vim go thefuck rbenv pass keychain node@14 rg tmux java jenv python assh zsh gnupg openjdk pygments gpg-agent pinentry

brew link node@14 --force

ssh-keygen -t ed25519 -C "thomas@flack.it"

read -p 'Path to key [~/.ssh/id_ed25519]: ' keypathvar
keypathvar=${keypathvar:-"~/.ssh/id_ed25519"}

eval "$(ssh-agent -s)"

touch ~/.ssh/config

ssh-add -K $keypathvar

/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

chsh -s $(which zsh)

read -p 'Continue once uploaded key to Github [y]: ' contvar

mkdir -p ~/code/github.com/nonki

cd ~/code/github.com/nonki

git clone git@github.com:nonki/.vim.git

git clone git@github.com:nonki/.tmux.git

git clone git@github.com:nonki/.ssh.git

git clone git@github.com:nonki/.zsh.git

/bin/bash -c "$(cat .vim/link.sh)"
/bin/bash -c "$(cat .tmux/link.sh)"
/bin/bash -c "$(cat .ssh/link.sh)"
/bin/bash -c "$(cat .zsh/link.sh)"

# generate gpg key
# pass init "GPG KEY ID"
