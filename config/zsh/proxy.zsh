proxy() {
    hostip=$(ip route | grep default | awk '{print $3}')
    socks_hostport=7890
    http_hostport=7890
    export https_proxy="http://${hostip}:${http_hostport}"
    export http_proxy="http://${hostip}:${http_hostport}"
    export ALL_PROXY="socks5://${hostip}:${socks_hostport}"
    export all_proxy="socks5://${hostip}:${socks_hostport}"

    unset hostip socks_hostport http_hostport
}

unproxy() {
    unset ALL_PROXY
    unset https_proxy
    unset http_proxy
    unset all_proxy
}

listproxy() {
    echo $ALL_PROXY
    echo $all_proxy
    echo $https_proxy
    echo $http_proxy
}