#!/usr/bin/env zsh
#!/bin/zsh
#   ______                 __ _ _
#  |___  /                / _(_) |
#     / / _ __  _ __ ___ | |_ _| | ___
#    / / | '_ \| '__/ _ \|  _| | |/ _ \
#  ./ /__| |_) | | | (_) | | | | |  __/
#  \_____/ .__/|_|  \___/|_| |_|_|\___|
#        | |
#        |_|
#
## This file is sourced before zshrc

################################
# Set PAHTHS #
################################

# Set specific path variables
export MODULE_DIR=$ZDOTDIR/modules
export PLUGIN_DIR=$XDG_CONFIG_HOME/plugins

# Set LANG if not set by the system (MacOS)
(( ${+LANG} )) || export LANG='en_US.UTF-8'

# Set standard paths
path=(
  /usr/local/opt/coreutils/libexec/gnubin(N)   # Gnu Core utils MacOS
  /usr/local/opt/gnu-time/libexec/gnubin(N)    # Gnu-time MacOS
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  ~/bin
  $path
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

# Add completion add the begining of fpath and custom functions at the end
fpath=( "$PLUGIN_DIR/zsh-users/zsh-completions/src" "${fpath[@]}" )

# Ensure path arrays do not contain duplicates.
typeset -gU path manpath fpath

################################
# EXPORT OS SPECIFIC VARIABLES #
################################
if [[ "$OSTYPE" == darwin* ]]; then
  # Load specific Mac OS Settings:
  builtin source $ZDOTDIR/.zprofile.mac
else
  # Load specific Arch Settings:
  builtin source $ZDOTDIR/.zprofile.arch
fi

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

# editor
export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

# Set the default Less options.
# -g: The -g option highlights only the first search occurence
# -i: Causes searches to ignore case
# -M: Causes less to prompt even more verbosely than more.
# -r: Causes "raw" control characters to be displayed, the screen appearance is not maintained.
# -R: Like -r, but only ANSI "color" escape sequences are output in "raw" form, the screen appearance is maintained.
# -S: Causes lines longer than the screen width to be truncated rather than wrapped.
# -w: Temporarily highlights the first "new" line after a forward movement of a full page.
# -X: Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# z-4: if the screen is x lines, -z-4 sets the scrolling window to x-4 lines.
# export LESS='-g -i -M -R -S -w -X -z-4'
export LESS='-g -i -M -R -S -w -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  #export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
  export LESSOPEN="|/usr/bin/lesspipe.sh %s"
fi
