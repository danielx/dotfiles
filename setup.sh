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

# ssh
ln -fs "${BASEDIR}/ssh/rc" "$HOME/.ssh/rc"

# vim
ln -fs "${BASEDIR}/vim/vimrc" "$HOME/.vimrc"
if [ -d "$HOME/.config/nvim" ]; then
	rm -rf "$HOME/.config/nvim"
fi
ln -fs "${BASEDIR}/nvim" "$HOME/.config/nvim"

# tmux
TMUX_HOME="$HOME/.config/tmux"
if [ -d "$TMUX_HOME" ]; then
	rm -rf "$TMUX_HOME"
fi
ln -fs "${BASEDIR}/tmux" "$TMUX_HOME"
ln -fs "${BASEDIR}/scripts/tmux-status-meminfo" "$HOME/.local/bin/tmux-status-meminfo"
ln -fs "${BASEDIR}/scripts/tmux-status-loadinfo" "$HOME/.local/bin/tmux-status-loadinfo"

if [ ! -d "$TMUX_HOME/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm "$TMUX_HOME/plugins/tpm"
fi

mkdir -p "$HOME/.config/lazygit"
ln -fs "${BASEDIR}/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

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
if [ -d "$XDG_CONFIG_HOME/zsh" ]; then
	rm -rf "$XDG_CONFIG_HOME/zsh"
fi

ln -fs "${BASEDIR}/zsh" "$XDG_CONFIG_HOME/zsh"

if ! [ -d "$XDG_CONFIG_HOME/zsh/plugins" ]; then
	# install plugins
	git clone git@github.com:hlissner/zsh-autopair.git "$XDG_CONFIG_HOME/zsh/plugins/zsh-autopair"
	git clone git@github.com:zsh-users/zsh-autosuggestions.git "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions"
	git clone git@github.com:zsh-users/zsh-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting"
fi

ln -fs "${BASEDIR}/zsh/zshrc" "$HOME/.zshrc"
ln -fs "${BASEDIR}/zsh/zshenv" "$HOME/.zshenv"
ln -fs "${BASEDIR}/zsh/zprofile" "$HOME/.zprofile"
