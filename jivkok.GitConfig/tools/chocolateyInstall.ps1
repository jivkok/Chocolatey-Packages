$package = 'jivkok.GitConfig'

# inspired by
# https://git.wiki.kernel.org/index.php/Aliases
# https://gist.github.com/bradwilson/4215933
# https://gist.github.com/oli/1637874

# Prereqs

$git_exe = 'git.exe'
if ((Get-Command $git_exe -ErrorAction SilentlyContinue) -eq $null)
{
  if (Test-Path "${env:ProgramW6432}\Git\bin\git.exe")
  {
    $git_exe = "${env:ProgramW6432}\Git\bin\git.exe"
  }
  elseif (Test-Path "${env:ProgramFiles(x86)}\Git\bin\git.exe")
  {
    $git_exe = "${env:ProgramFiles(x86)}\Git\bin\git.exe"
  }
  else
  {
    throw 'Could not find git.exe'
  }
}
Write-Output "Found Git: $git_exe"

setx TERM cygwin /M
$kdiffPath = "$env:ProgramW6432\KDiff3\kdiff3.exe"
if (Test-Path $kdiffPath) { Write-Output "Found KDiff3 at: $kdiffPath" } else { Write-Warning "Could not find KDiff3 at: $kdiffPath" }

# Core
. $git_exe config --global core.autocrlf true
. $git_exe config --global core.preloadindex true
. $git_exe config --global core.fscache true
. $git_exe config --global core.safecrlf false
$defaultEditor = . $git_exe config --get core.editor
if (!$defaultEditor)
{
  . $git_exe config --global core.editor notepad
}
. $git_exe config --global help.format html
. $git_exe config --global pack.packSizeLimit 2g
. $git_exe config --global push.default current
. $git_exe config --global rebase.autosquash true

# Colors
. $git_exe config --global color.branch.current "red bold"
. $git_exe config --global color.branch.local normal
. $git_exe config --global color.branch.remote "yellow bold"
. $git_exe config --global color.branch.plain normal
. $git_exe config --global color.diff.meta "yellow bold"
. $git_exe config --global color.diff.frag "magenta bold"
. $git_exe config --global color.diff.old "red bold"
. $git_exe config --global color.diff.new "green bold"
. $git_exe config --global color.status.header normal
. $git_exe config --global color.status.new "red bold"
. $git_exe config --global color.status.added "green bold"
. $git_exe config --global color.status.updated "cyan bold"
. $git_exe config --global color.status.changed "cyan bold"
. $git_exe config --global color.status.untracked "red bold"
. $git_exe config --global color.status.nobranch "red bold"

# Diff & Merge
if (Test-Path $kdiffPath)
{
  . $git_exe config --global diff.tool kdiff3
  . $git_exe config --global diff.guitool kdiff3
  . $git_exe config --global difftool.prompt false
  . $git_exe config --global difftool.kdiff3.path "$kdiffPath"
  . $git_exe config --global difftool.kdiff3.keepBackup false
  . $git_exe config --global difftool.kdiff3.trustExitCode false

  . $git_exe config --global merge.tool kdiff3
  . $git_exe config --global mergetool.prompt false
  . $git_exe config --global mergetool.kdiff3.path "$kdiffPath"
  . $git_exe config --global mergetool.kdiff3.keepBackup false
  . $git_exe config --global mergetool.kdiff3.trustExitCode false
}

# Aliases
. $git_exe config --global alias.a 'add -A'
. $git_exe config --global alias.aliases 'config --get-regexp alias'
. $git_exe config --global alias.amend 'commit --amend -C HEAD'
. $git_exe config --global alias.bl 'blame -w -M -C'
. $git_exe config --global alias.br 'branch'
. $git_exe config --global alias.bra 'branch -rav'
. $git_exe config --global alias.branches 'branch -rav'
. $git_exe config --global alias.cat 'cat-file -t'
. $git_exe config --global alias.cm 'commit -m'
. $git_exe config --global alias.co 'checkout'
. $git_exe config --global alias.df 'diff --word-diff=color --word-diff-regex=. -w --patience'
. $git_exe config --global alias.dump 'cat-file -p'
. $git_exe config --global alias.files '! git ls-files | grep -i'
. $git_exe config --global alias.filelog 'log -u'
. $git_exe config --global alias.hist "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) [%an]%Creset' --abbrev-commit --date=relative"
. $git_exe config --global alias.l 'log --pretty=format:\"%h %ad | %s%d [%an]\" --date=short'
. $git_exe config --global alias.last 'log -p --max-count=1 --word-diff'
. $git_exe config --global alias.lastref 'rev-parse --short HEAD'
. $git_exe config --global alias.lasttag 'describe --tags --abbrev=0'
. $git_exe config --global alias.lg 'log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short'
. $git_exe config --global alias.loglist 'log --oneline'
. $git_exe config --global alias.pick 'add -p'
. $git_exe config --global alias.pp 'pull --prune'
. $git_exe config --global alias.pullom 'pull origin master'
. $git_exe config --global alias.pushom 'push origin master'
. $git_exe config --global alias.re 'rebase'
. $git_exe config --global alias.reabort 'rebase --abort'
. $git_exe config --global alias.rego 'rebase --continue'
. $git_exe config --global alias.reskip 'rebase --skip'
. $git_exe config --global alias.remotes 'remote -v show'
. $git_exe config --global alias.st 'status -sb'
. $git_exe config --global alias.stats 'diff --stat'
. $git_exe config --global alias.undo 'reset HEAD~'
. $git_exe config --global alias.unstage 'reset HEAD'
. $git_exe config --global alias.wdiff 'diff --word-diff'
. $git_exe config --global alias.who 'shortlog -s -e --'
. $git_exe config --global alias.zap 'reset --hard HEAD'
$userName = . $git_exe config --global --get user.name
if ($userName)
{
  . $git_exe config --global alias.standup "log --since yesterday --oneline --author $userName"
}
else
{
  Write-Warning "Set git global username with git config --global user.name 'foo' to use standup"
}
