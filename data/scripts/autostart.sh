#! /bin/bash

# ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    echo "ssh-agent 未启动，正在启动..."
    eval "$(ssh-agent -s)"
else
    echo "ssh-agent 已经启动"
fi

