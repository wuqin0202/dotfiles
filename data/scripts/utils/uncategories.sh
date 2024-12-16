find /path/to/directory -type d -exec chmod 755 {} \; -o -type f -exec chmod 644 {} \; # 递归修改目录权限为755，文件权限为644
