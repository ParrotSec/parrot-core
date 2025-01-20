#!/bin/bash
# Make sure PATH includes sbin
if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
    PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
fi

# Make sure PATH includes snap
if ! echo "$PATH" | tr : '\n' | grep -q "^/snap$"; then
    PATH="/snap/bin:$PATH"
fi

# Make sure PATH includes local
if ! echo "$PATH" | tr : '\n' | grep -q "^/usr/local/bin$"; then
    PATH="/usr/local/bin:$PATH"
fi

# Make sure PATH includes $HOME paths
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi
