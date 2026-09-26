function update-helmfile
    set -l ver (curl -fsSL https://api.github.com/repos/helmfile/helmfile/releases/latest | jq -r .tag_name); or return
    curl -fsSL "https://github.com/helmfile/helmfile/releases/download/$ver/helmfile_"(string replace -r '^v' '' $ver)"_linux_amd64.tar.gz" |
        sudo tar -xz -C /usr/local/bin helmfile
end
