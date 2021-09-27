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
ZSH_PROFILE=0
if [ $ZSH_PROFILE -gt 0 ]; then
  zmodload zsh/zprof
fi

## Load custom functions
# Add current functions dir to fpath and autoload functions
fpath+=("$ZDOTDIR/functions")
# Autoload custom functions
autoload -Uz $fpath[-1]/*(.:t)

# Disable all beeps
setopt no_beep

## Set prompt
# Verry simple prompt
PROMPT='%F{green}%n%f %F{cyan}%(4~|%-1~/.../%2~|%~)%f %F{magenta}%B>%b%f '
RPROMPT='%(?.%F{green}.%F{red}[%?] - )%B%D{%H:%M:%S}%b%f'#

source ~/zpmod/zmod.zsh

declare -A MODULES
MODULES=(
    "aliases"
    "history"
    "colored-man"
    "dircolor"
    "completion"
)

for module in $MODULES; do
  zmod load "$MODULE_DIR/$module/$module.zsh" "$module"
done

declare -A PLUGINS
PLUGINS=(
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "zsh-history-substring-search"
)

#
# Zprofile
#
if [ $ZSH_PROFILE -gt 0 ]; then
  now=$(date | awk -F ',' '{ printf "%s %s", $1, $2 }' | awk '{ printf "%s-%s_%s", $2, $3, $5 }')
  [[ ! -d "$ZSH_CACHE_DIR/zprof" ]] && mkdir -p "$ZSH_CACHE_DIR/zprof"
  LC_NUMERIC="en_US.UTF-8" zprof >> $ZSH_CACHE_DIR/zprof/$now.zprofile
  LC_NUMERIC="en_US.UTF-8" zprof | awk 'NR == 3 { print "Startup Time: ", $3/$8*100, "ms"}'
fi
