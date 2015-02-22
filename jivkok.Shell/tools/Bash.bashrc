# OS
export OS="$(uname -s)"

# Shell
if test -n "$ZSH_VERSION"; then
    export PROFILE_SHELL='zsh'
elif test -n "$BASH_VERSION"; then
    export PROFILE_SHELL='bash'
elif test -n "$KSH_VERSION"; then
    export PROFILE_SHELL='ksh'
elif test -n "$FCEDIT"; then
    export PROFILE_SHELL='ksh'
elif test -n "$PS3"; then
    export PROFILE_SHELL='unknown'
else
    export PROFILE_SHELL='sh'
fi

# Load the shell dotfiles, (~/.bash_extra can be used for any local settings you don’t want to commit)
for file in ~/.{bash_prompt,aliases,functions,bash_extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

## set options
set -o vi               # vi keys
set -o noclobber        # prevent overwriting files with cat

# Shell options
shopt -s cdspell               # Autocorrect typos in path names when using `cd`
shopt -s checkwinsize          # Make sure terminals wrap lines correctly after resizing them
shopt -s dotglob               # files beginning with . to be returned in the results of path-name expansion.
shopt -s histappend            # Append to history (http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html)
shopt -s nocaseglob            # Case-insensitive globbing (used in pathname expansion)
# Enable some Bash 4 features when possible
shopt -s autocd 2> /dev/null   # * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
shopt -s globstar 2> /dev/null # * Recursive globbing, e.g. `echo **/*.txt`

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# node.js and nvm (http://nodejs.org/api/repl.html#repl_repl)
alias node="env NODE_NO_READLINE=1 rlwrap node"
alias node_repl="node -e \"require('repl').start({ignoreUndefined: true})\""
export NODE_DISABLE_COLORS=1
if [ -s ~/.nvm/nvm.sh ]; then
    NVM_DIR=~/.nvm
    source ~/.nvm/nvm.sh
    nvm use v0.10.12 &> /dev/null # silence nvm use; needed for rsync
fi

if [ "$OS" = "Linux" ]; then

    # Set up umask permissions (http://en.wikipedia.org/wiki/Umask)
    # umask 002 allows only you to write (but the group to read) any new files that you create.
    # umask 022 allows both you and the group to write to any new files which you make.
    # In general we want umask 022 on the server and umask 002 on local machines.
    # The command 'id' gives the info we need to distinguish these cases.
    #    $ id -gn  #gives group name
    #    $ id -un  #gives user name
    #    $ id -u   #gives user ID
    # So: if the group name is the same as the username OR the user id is not greater than 99
    # (i.e. not root or a privileged user), then we are on a local machine, so we set umask 002.
    if [ "`id -gn`" == "`id -un`" -a `id -u` -gt 99 ]; then
        umask 002
    else
        umask 022
    fi

    # Add tab completion for many Bash commands
    if [ -f /etc/bash_completion ]; then
        source /etc/bash_completion;
    fi;

elif [ "$OS" = "Darwin" ]; then

    # Add tab completion for many Bash commands
    if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        source "$(brew --prefix)/etc/bash_completion";
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion;
    fi;

    # Add tab completion for `defaults read|write NSGlobalDomain`
    # You could just use `-g` instead, but I like being explicit
    complete -W "NSGlobalDomain" defaults;

    # Add `killall` tab completion for common apps
    complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

fi
