# 安装 Aria2-Pro
docker run -d \
    --name aria2-pro \
    --restart unless-stopped \
    --log-opt max-size=1m \
    --network host \
    -e PUID=$UID \
    -e PGID=$GID \
    -e RPC_SECRET=<TOKEN> \
    -e RPC_PORT=6800 \
    -e LISTEN_PORT=6888 \
    -e SPECIAL_MODE=move \
    -v $XDG_CONFIG_HOME/aria2:/config \
    -v $HOME/Downloads:/downloads \
    p3terx/aria2-pro
# 参看 <https://p3terx.com/archives/docker-aria2-pro.html>

# 安装 ariang
docker run -d \
--name ariang \
--log-opt max-size=1m \
--restart unless-stopped \
--network host \
p3terx/ariang
# 参看 <https://www.cnblogs.com/wqp001/p/14709997.html>
