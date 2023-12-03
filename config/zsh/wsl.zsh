# 判断是否为 wsl
if [ $(uname -r | grep -i "wsl") ]; then
    is_wsl="yes"
else
    is_wsl="no"
fi

if [ $is_wsl = "yes" ]; then
    rm -rf $HOME/.conda
    rm -f $HOME/.sudo_as_admin_successful

    export PATH="${PATH:+$PATH:}/usr/local/cuda/bin"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}/usr/local/cuda/lib64"
fi

unset is_wsl