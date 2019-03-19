# Make sure PATH includes sbin support
if ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
    PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
fi

# Make sure PATH includes snap support
if ! echo "$PATH" | tr : '\n' | grep -q "^/snap$"; then
    PATH="/snap/bin:$PATH"
fi






