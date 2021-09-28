#!/usr/bin/env zsh
#!/bin/zsh

#@source_plugins $PLUGINS
for plug in $PLUGINS; do
  builtin source "$ZDOTDIR/plugins.d/$plug.zsh"
done

## Initialize compinit
run-compinit
