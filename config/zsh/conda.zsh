conda_path=/opt/$(ls /opt | grep -i conda)/etc/profile.d/conda.sh
[ -e "$conda_path" ] && source $conda_path

unset conda_path