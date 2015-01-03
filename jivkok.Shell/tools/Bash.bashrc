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

# Shell options
# Make sure terminals wrap lines correctly after resizing them
shopt -s checkwinsize
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Append to history (http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html)
shopt -s histappend
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

set -o noclobber

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
