#!/bin/sh

BASEDIR=$(cd "$(dirname "$0")"; pwd)

# fetch git submodules
git submodule update --init --recursive

# git
if [ ! -f "$BASEDIR/git/gitconfig.local" ]; then
	cp "$BASEDIR/git/gitconfig.local-example" "$BASEDIR/git/gitconfig.local"
fi

ln -fs "${BASEDIR}/git/gitconfig" "$HOME/.gitconfig"
ln -fs "${BASEDIR}/git/gitconfig.local" "$HOME/.gitconfig.local"
ln -fs "${BASEDIR}/git/gitignore_global" "$HOME/.gitignore_global"

# vim
ln -fs "${BASEDIR}/vim/vimrc" "$HOME/.vimrc"

# zsh
if [ -d "$HOME/.zsh_custom" ]; then
	rm -rf "$HOME/.zsh_custom"
fi

ln -fs "${BASEDIR}/zsh/zsh_custom" "$HOME/.zsh_custom"
ln -fs "${BASEDIR}/zsh/zshrc" "$HOME/.zshrc"
ln -fs "${BASEDIR}/zsh/zshenv" "$HOME/.zshenv"
