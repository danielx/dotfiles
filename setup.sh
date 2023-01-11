#!/bin/sh

BASEDIR=$(
	cd "$(dirname "$0")" || exit 1
	pwd
)

# git
if [ ! -f "$BASEDIR/git/gitconfig.local" ]; then
	cp "$BASEDIR/git/gitconfig.local-example" "$BASEDIR/git/gitconfig.local"
fi

ln -fs "${BASEDIR}/git/gitconfig" "$HOME/.gitconfig"
ln -fs "${BASEDIR}/git/gitconfig.local" "$HOME/.gitconfig.local"
ln -fs "${BASEDIR}/git/gitignore_global" "$HOME/.gitignore_global"

# vim
ln -fs "${BASEDIR}/vim/vimrc" "$HOME/.vimrc"
if [ -d "$HOME/.config/nvim" ]; then
	rm -rf "$HOME/.config/nvim"
fi
ln -fs "${BASEDIR}/nvim" "$HOME/.config/nvim"

# tmux
ln -fs "${BASEDIR}/tmux/tmux.conf" "$HOME/.tmux.conf"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# script to handle copying text to the host terminal on remote sessions using
# the OSC 52 escape sequence.
# supported by iterm2 on macos and rxvt-unicode (requires custom extension).
if [ "$(uname)" = "Linux" ]; then
	# only install on linux since iterm2 handles it w/o needing this in tmux
	mkdir -p "$HOME/.local/bin"
	ln -fs "${BASEDIR}/scripts/yank" "$HOME/.local/bin/yank"
fi

# rxvt-unicode on linux since it supports OSC 52
if [ "$(uname)" = "Linux" ]; then
	ln -fs "${BASEDIR}/Xresources" "$HOME/.Xresources"
	if [ -d "$HOME/.urxvt" ]; then
		rm -rf "$HOME/.urxvt"
	fi

	ln -fs "${BASEDIR}/urxvt" "$HOME/.urxvt"
fi

# zsh
if [ -d "$HOME/.zsh_custom" ]; then
	rm -rf "$HOME/.zsh_custom"
fi

ln -fs "${BASEDIR}/zsh/zsh_custom" "$HOME/.zsh_custom"
ln -fs "${BASEDIR}/zsh/zshrc" "$HOME/.zshrc"
ln -fs "${BASEDIR}/zsh/zshenv" "$HOME/.zshenv"
