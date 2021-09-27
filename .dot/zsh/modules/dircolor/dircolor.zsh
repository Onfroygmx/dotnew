#!/bin/zsh
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

local currentdir=${${(%):-%x}:a:h}
dircolor_basedir="$0:h"

# Source generated file only if does not exist or older then config file
if [[ ! -f $ZSH_CACHE_DIR/ls_colors.zsh || $currentdir/LS_COLORS -nt $ZSH_CACHE_DIR/ls_colors.zsh ]]; then
  [[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p $ZSH_CACHE_DIR
  dircolors -b $currentdir/LS_COLORS > $ZSH_CACHE_DIR/ls_colors.zsh
  zcompile $ZSH_CACHE_DIR/ls_colors.zsh
fi
source $ZSH_CACHE_DIR/ls_colors.zsh
