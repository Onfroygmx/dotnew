#!/usr/bin/env zshé
#!/bin/zsh

builtin source $PLUGIN_DIR/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('brew install *' 'fg=white,bold,bg=green')
