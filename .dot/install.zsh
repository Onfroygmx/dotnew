#!/usr/bin/env zsh
#!/bin/zsh
#   _____          _        _ _
#  |_   _|        | |      | | |
#    | | _ __  ___| |_ __ _| | |
#    | || '_ \/ __| __/ _` | | |
#   _| || | | \__ \ || (_| | | |
#   \___/_| |_|___/\__\__,_|_|_|
#
# https://patorjk.com/software/taag/#p=display&c=bash&f=Doom&t=Install
### Install basic tools
## zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Onfroygmx/dotnew/master/.dot/install.zsh)"

## Autoload zsh functions
#################################################
autoload -U colors && colors

## Export work folders
#################################################
export XDG_CONFIG_HOME=$HOME/.dot
export XDG_DATA_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"/data

# ZSH specifi dirs
export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"/zsh

printf "\n$fg[green]Clone: Onfroygmx/zsh$reset_color\n"
git clone --bare https://github.com/Onfroygmx/dotnew.git $HOME/.dotgit
git --git-dir=$HOME/.dotgit --work-tree=$HOME checkout

printf "\n$fg[green]Symlink zshenv file$reset_color\n"
## Set zshenv file
[[ ! -f $HOME/.zshenv && -f $ZDOTDIR/zshenv ]] && ln -s $ZDOTDIR/zshenv $HOME/.zshenv

printf "\n$fg[green]Create other folders$reset_color\n"
# Create plugins dir
PLUGINS_DIR="$XDG_CONFIG_HOME/plugins"
[[ ! -d "$PLUGINS_DIR" ]] && mkdir -p $PLUGINS_DIR


printf "\n$fg[green]Set permission 700 to all created folders$reset_color\n"
find $XDG_CONFIG_HOME -type d -print0 | xargs -0 chmod 700
mv .dotgit $XDG_CONFIG_HOME

printf "\n$fg[Cyan]Clone external Plugins$reset_color\n"

printf "\n$fg[green]Clone: zsh-users/zsh-autosuggestions$reset_color\n"
git clone https://github.com/Onfroygmx/zmod.git $PLUGINS_DIR/zmod

printf "\n$fg[green]Clone: zsh-users/zsh-autosuggestions$reset_color\n"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $PLUGINS_DIR/zsh-users/zsh-autosuggestions
printf "\n$fg[green]Clone: zsh-users/zsh-completions$reset_color\n"
git clone https://github.com/zsh-users/zsh-completions.git $PLUGINS_DIR/zsh-users/zsh-completions
printf "\n$fg[green]Clone: zsh-users/zsh-history-substring-search$reset_color\n"
git clone https://github.com/zsh-users/zsh-history-substring-search.git $PLUGINS_DIR/zsh-users/zsh-history-substring-search
printf "\n$fg[green]Clone: zsh-users/zsh-syntax-highlighting$reset_color\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_DIR/zsh-users/zsh-syntax-highlighting.git

printf "\n$fg[yellow]Install fininshed, restart ZSH$reset_color\n"

# Link configuration files to correct place
ln -s $XDG_CONFIG_HOME/data/nano/nanorc $HOME/.nanorc
ln -s $XDG_CONFIG_HOME/data/git/gitconfig $HOME/.gitconfig
ln -s $XDG_CONFIG_HOME/data/git/gitmessage $HOME/.gitmessage
ln -s $XDG_CONFIG_HOME/data/git/gitignore_global $HOME/.gitignore_global
