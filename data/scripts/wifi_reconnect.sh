
WIFI_NAME="qin's room"
while true; do
    ping -c 1 "www.baidu.com" > /dev/null
    if [ $? -eq 0 ]; then
        sleep 600
    else
        iwctl station wlan0 connect $WIFI_NAME
        sleep 120
    fi
done