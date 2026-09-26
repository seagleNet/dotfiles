function bass -d "Source bash script, then exec back into fish" -a path
    exec bash -c 'source "$1"; exec fish' bash $path
end
