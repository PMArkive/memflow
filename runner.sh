#!/usr/bin/env bash

if [[ -n $RUST_SUDO ]]; then

    exec sudo -E "$@"

else

    if [[ -n $RUST_SETPTRACE ]]; then
        if [[ -z "$(getcap "$1" | grep -i cap_sys_ptrace)" ]]; then
            echo "setting CAP_SYS_PTRACE=ep for $1"
            sudo setcap 'CAP_SYS_PTRACE=ep' "$1"
        fi
    fi

    exec "$@"

fi
