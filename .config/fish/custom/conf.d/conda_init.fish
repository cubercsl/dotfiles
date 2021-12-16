# depreciated
switch (uname)
case Linux
    # ArchLinux install Anaconda at /opt
    test -d /opt/anaconda; and set CONDA_ROOT /opt/anaconda
case Darwin
    # Homebrew install Anaconda at /usr/local
    test -d /usr/local/anaconda3; and set CONDA_ROOT /usr/local/anaconda3
end

if test -n "$CONDA_ROOT"
    and test -f "$CONDA_ROOT/bin/conda"
    eval "$CONDA_ROOT/bin/conda" "shell.fish" "hook" $argv | source
end
