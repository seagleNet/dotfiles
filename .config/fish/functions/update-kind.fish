function update-kind
    sudo curl -fsSL https://github.com/kubernetes-sigs/kind/releases/latest/download/kind-linux-amd64 -o /usr/local/bin/kind
    sudo chmod +x /usr/local/bin/kind
end
