# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ "${PS1-}" ]; then
  if [ "${BASH-}" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    # PS1='\h:\w\$ '
    if [ -f ~/.bashrc ]; then
     . ~/.bashrc
    elif [ -f /etc/bash.bashrc ]; then
      . /etc/bash.bashrc
    fi
  else
    if [ "$(id -u)" -eq 0 ]; then
      PS1='┌──[\u@\h]─[\w]\n└──╼ \$#'
    else
      PS1='┌──[\u@\h]─[\w]\n└──╼ \$'
    fi
  fi
fi
