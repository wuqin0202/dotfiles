KEY_FILE="/home/wuqin/.ssh/aliyun_key"
# ssh
autossh -M 2000 -qnCTN -R 2222:localhost:22 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" root@47.97.168.47 -i $KEY_FILE &
# nascab
autossh -M 2002 -qnCTN -R 8888:localhost:8888 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" root@47.97.168.47 -i $KEY_FILE &
# mysql
autossh -M 2004 -qnCTN -R 3306:localhost:3306 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" root@47.97.168.47 -i $KEY_FILE &
# v2raya
autossh -M 2006 -qnCTN -R 2017:localhost:2017 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" root@47.97.168.47 -i $KEY_FILE &
# aria2
autossh -M 2008 -qnCTN -R 6800:localhost:6800 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" root@47.97.168.47 -i $KEY_FILE &
# 保留
autossh -M 2024 -qnCTN -R 4000:localhost:4000 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" root@47.97.168.47 -i $KEY_FILE &