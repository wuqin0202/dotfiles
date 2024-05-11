#!/bin/bash

# crontab -e
# 0  2  *  *  * /bin/bash /path/to/autobackup.sh
# 分 时 日 月 周
echo "$(date +"%Y-%m-%d %H:%M:%S"): Start Backup"
BACKUP_PATHS=(
    "/home/wuqin/Workspace"
)

BACKUP_DIR="/root/backups"
HIST_FILE_NUM=7

if [ ! -d $BACKUP_DIR ]; then
    mkdir $BACKUP_DIR
fi

delete_old_file() {
    local target_dir=$1
    local file_num=$(ls -l $target_dir | grep "^-" | wc -l)
    if [ $file_num -gt $HIST_FILE_NUM ]; then
        local files=($(ls -t $target_dir))
        for ((i=$HIST_FILE_NUM; i<$file_num; i++)); do
            rm -f $target_dir/${files[$i]}
            echo -e "\tDelete $target_dir/${files[$i]} successfully."
        done
    fi
}

backup() {
    local source_file=$1
    if [ -e $source_file ]; then
        local target_file="$BACKUP_DIR/$(basename $source_file)/$(date +"%Y_%m_%d_%H_%M_%S").tar.gz"
        mkdir -p $(dirname "$target_file")
        tar -czf "$target_file" -C $(dirname "$source_file") $(basename "$source_file")
        echo -e "\tBackup $source_file to $target_file successfully."
        delete_old_file $(dirname "$target_file")
    else
        echo -e "\tError: $source_file does not exist."
    fi
    echo
}

for path in ${BACKUP_PATHS[@]}; do
    backup $path
done
