export PATH=$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# Load the shell dotfiles (~/.path can be used to extend `$PATH`)
for file in ~/.{bashrc,exports,path}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
