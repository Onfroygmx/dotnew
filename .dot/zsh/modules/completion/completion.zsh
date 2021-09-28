#!/bin/zsh
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

fpath+=( "${0:h}/functions" )

autoload -Uz run-compinit

#fpath+=(${0:a:h}/functions)
#autoload -Uz $fpath[-1]/*(.:t)

setopt complete_in_word    # Complete from both ends of a word.
setopt always_to_end       # Move cursor to the end of a completed word.
setopt path_dirs           # Perform path search even on command names with slashes.
setopt auto_menu           # Show completion menu on a successive tab press.
setopt auto_list           # Automatically list choices on ambiguous completion.
# setopt auto_param_flash    # If completed parameter is a directory, add a trailing slash.
setopt extended_glob       # Needed for file modification glob modifiers with compinit.
unsetopt menu_complete     # Do not autoselect the first completion entry.
unsetopt flow_control      # Disable start/stop characters in shell editor.

ZSH_CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache

# Enable completion caching & store cache file
zstyle ':completion:*' cache-path $ZSH_CACHE
zstyle ':completion:*' use-cache true

# Enable completers in order
zstyle ':completion:*' completer _oldlist _expand _complete _correct _complete:-fuzzy _ignored _approximate
# Increase the number of errors based on the length of the typed word. But make
# sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3)) numeric)'
# zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# Use menu completion
zstyle ':completion:*' menu select

# Verbose completion results
zstyle ':completion:*' verbose true

# Each 'string in quotes' is tried in order until one them succeeds.
# r:|[.]=** does .bar -> foo.bar
# r:?|[-_]=** does f-b -> foo-bar and F_B -> FOO_BAR
# l:?|=[-_] does foobar -> foo-bar and FOOBAR -> FOO_BAR
# m:{[:lower:]-}={[:upper:]_} does foo-bar -> FOO_BAR (but not vice versa)
# r:|?=** does fbr -> foo-bar and bar -> foo-bar
zstyle ':completion:*:complete:*' matcher-list 'r:|[.]=** r:?|[-_]=** l:?|=[-_] m:{[:lower:]-}={[:upper:]_}'
zstyle ':completion:*:complete-fuzzy:*' matcher-list 'r:|?=** m:{[:lower:]}={[:upper:]}'
zstyle ':completion:*:options' matcher 'b:-=+'  # For options, do -x -> +x
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Group results by category
zstyle ':completion:*' group-name ''

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

# Pretty messages during pagination
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Nicer format for completion messages
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format '%U%F{green}%B%d%b%u'											# Show group titles underlined.
zstyle ':completion:*:expansions' format "%B%d%b for '%o'"
zstyle ':completion:*:corrections' format '%U%F{214}%d (errors: %e)%f%u'							# Corrections in orange
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'	# Dark organge for message, light orange for completers
zstyle ':completion:*' format '%F{yellow}-- %d --%f'																	# Default if other styles don't match

# Show message while waiting for completion
zstyle ':completion:*' show-completer true

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# Prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $LOGNAME -o pid,user,command -w"

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Use ls-colors for path completions
function _set-list-colors() {
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} "ma=52;5;153;1"
	unfunction _set-list-colors
}
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet
