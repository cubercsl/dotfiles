switch (uname)
case Linux
    # ArchLinux install Anaconda at /opt
    set CONDA_ROOT /opt/anaconda
case Darwin
    # Homebrew install Anaconda at /usr/local
    set CONDA_ROOT /usr/local/anaconda3
end

eval $CONDA_ROOT/bin/conda "shell.fish" "hook" $argv | source
