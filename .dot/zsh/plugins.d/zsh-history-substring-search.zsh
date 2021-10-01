#!/usr/bin/env zshé
#!/bin/zsh

builtin source $PLUGIN_DIR/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh

# Set history search options
HISTORY_SUBSTRING_SEARCH_FUZZY=set
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=set

# Bind ^[[A/^[[B for history search after sourcing the file
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
