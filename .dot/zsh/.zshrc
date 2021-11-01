#!/usr/bin/env zsh
#!/bin/zsh
#   ______    _
#  |___  /   | |
#     / / ___| |__  _ __ ___
#    / / / __| '_ \| '__/ __|
#  ./ /__\__ \ | | | | | (__
#  \_____/___/_| |_|_|  \___|
#

#
# Zprofile
#
# To launch:
# ZSH_PROFILE=true zsh -ic zprof
if [[ "$ZSH_PROFILE" = true ]]; then
  [[ ! -d "$ZSH_CACHE_DIR/zprof" ]] && mkdir -p "$ZSH_CACHE_DIR/zprof"
  zmodload zsh/zprof
fi

#
# Ztrace
#
# To launch:
# ZSH_XTRACE=true zsh
#if [[ $ZSH_XTRACE ]]; then
if [[ "$ZSH_XTRACE" = true ]]; then
  (( ${+EPOCHREALTIME} )) || zmodload zsh/datetime
  setopt PROMPT_SUBST
  PS4='+$EPOCHREALTIME %N:%i> '

  [[ ! -d "$ZSH_CACHE_DIR/xtrace" ]] && mkdir -p "$ZSH_CACHE_DIR/xtrace"
  logfile=$(mktemp "$ZSH_CACHE_DIR/xtrace"/zsh_xtrace.XXXXXXXX)
  echo "Logging to $logfile"
  exec 3>&2 2>$logfile

  setopt XTRACE
fi

## Load custom functions
# Add current functions dir to fpath and autoload functions
#fpath+=("$ZDOTDIR/functions")
# Autoload custom functions
#autoload -Uz $fpath[-1]/*(.:t)

# Disable all beeps
setopt no_beep

## Set prompt
# Verry simple prompt
PROMPT='%F{green}%n%f %F{cyan}%(4~|%-1~/.../%2~|%~)%f %F{magenta}%B>%b%f '
RPROMPT='%(?.%F{green}.%F{red}[%?] - )%B%D{%H:%M:%S}%b%f'

builtin source $PLUGIN_DIR/zmod/zmod.zsh

#declare -A MODULES
MODULES=(
    aliases
    history
    colored-man
    dircolor
    completion
)

#Source module files
for module in $MODULES; do
  zmod load "$MODULE_DIR/$module/$module.zsh" "module/$module"
done

#declare -A PLUGINS
PLUGINS=(
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-history-substring-search
)

#Source plugin files
for plug in $PLUGINS; do
  zmod load "$ZDOTDIR/plugins.d/${plug:t}.zsh" "$plug"
done

## Initialize compinit
run-compinit

#
# Zprofile
#
if [[ "$ZSH_PROFILE" = true ]]; then
  LC_NUMERIC="en_US.UTF-8" zprof | awk 'NR == 3 { print "Startup Time: ", $3/$8*100, "ms"}'
  now=$(date +"%Y-%m-%d_%H:%M:%S")
  LC_NUMERIC="en_US.UTF-8" zprof >> $ZSH_CACHE_DIR/zprof/$now.zprofile
fi

if [[ "$ZSH_XTRACE" = true ]]; then
  unsetopt XTRACE
  exec 2>&3 3>&-
fi
