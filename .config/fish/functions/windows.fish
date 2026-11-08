function windows --description 'Reboot into Windows (one-time)'
    sudo efibootmgr --bootnext 0000 >/dev/null && systemctl reboot
end
