function update-helmfile
    sudo curl -fsSL https://github.com/roboll/helmfile/releases/latest/download/helmfile_linux_amd64 -o /usr/local/bin/helmfile
    sudo chmod +x /usr/local/bin/helmfile
end
