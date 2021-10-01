#!/bin/zsh
# history.zsh
#    _   _ _     _
#   | | | (_)___| |_ ___  _ __ _   _
#   | |_| | / __| __/ _ \| '__| | | |
#   |  _  | \__ \ || (_) | |  | |_| |
#   |_| |_|_|___/\__\___/|_|   \__, |
#                              |___/

#
# Options
#

# http://zsh.sourceforge.net/Doc/Release/Options.html#History
# setopt append_history          # append to history file at the end of session
setopt inc_append_history      # write to the history file immediately, not when the shell exits
setopt bang_hist               # Treat the '!' character specially during expansion
setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt no_hist_beep            # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
#setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt no_share_history        # don't share history between all sessions

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
LESSHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}"/less/history
MYSQL_HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/mysql/history"

# you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
# (1000 and 2000 respectively), but if not we make them way bigger.
# The maximum number of events to save in the history file.
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=50000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000
