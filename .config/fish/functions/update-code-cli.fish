function update-code-cli
    set -l tarball (mktemp --suffix=.tar.gz)
    curl -fsSL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" -o $tarball
    and sudo tar -C /usr/local/bin -xf $tarball code
    and sudo chmod +x /usr/local/bin/code
    rm -f $tarball
end
