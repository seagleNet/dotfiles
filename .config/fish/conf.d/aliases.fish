status is-interactive; or return

# sudo
abbr -a sudo sudo -E

# vim
abbr -a vi vim

# batcat to bat
if type -q batcat
    abbr -a bat batcat
end

# gcloud
abbr -a gc gcloud

# fdfind to fd
if type -q fdfind
    abbr -a fd fdfind
end

# code-oss to code and vscode
if type -q code-oss
    abbr -a code code-oss
    abbr -a vscode code-oss
end

# eza to ls
if type -q eza
    abbr -a ls eza
end

# ansible-playbook to ap
if type -q ansible-playbook
    abbr -a ap ansible-playbook
end

# kubens
abbr -a kns kubens

# kubecx
abbr -a kcx kubectx

# update-* and please functions live in functions/ and are autoloaded on first use
