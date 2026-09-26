function update-kubectl
    set -l version (curl -fsSL https://dl.k8s.io/release/stable.txt); or return
    sudo curl -fsSL "https://dl.k8s.io/release/$version/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
    sudo chmod +x /usr/local/bin/kubectl
end
