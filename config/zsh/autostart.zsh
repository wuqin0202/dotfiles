# ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# conda
conda_path=/opt/$(ls /opt | grep -i conda)/etc/profile.d/conda.sh
[ -e "$conda_path" ] && source $conda_path

unset conda_path