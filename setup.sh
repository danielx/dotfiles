#!/bin/sh

BASEDIR=$(cd "$(dirname "$0")"; pwd)

if [ $(uname -s) = "Darwin" ]; then
	OS="macos"
	VSCODE_DIR="$HOME/Library/Application Support/Code"
elif [ $(uname -s) = "Linux" ]; then
	OS="linux"
	VSCODE_DIR="$HOME/.config/Code"
else
	echo "unsupported os $(uname -s)"
	exit 1
fi

# vscode
if [ ! -d "${VSCODE_DIR}" ]; then
	mkdir -p "${VSCODE_DIR}"
elif [ -d "${VSCODE_DIR}/User" ]; then
	rm -rf "${VSCODE_DIR}/User"
fi

ln -fs "${BASEDIR}/vscode" "${VSCODE_DIR}/User"

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

