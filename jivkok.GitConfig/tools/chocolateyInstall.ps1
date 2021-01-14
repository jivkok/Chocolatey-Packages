$package = 'jivkok.GitConfig'

# inspired by
# https://git.wiki.kernel.org/index.php/Aliases
# https://gist.github.com/bradwilson/4215933
# https://gist.github.com/oli/1637874

function SetDiffMergeTool($toolAlias) {
  # The alias must match teh namespacing used for configuring the diff/meerge tools. E.g. difftool.kdiff3.path -> alias is kdiff3

  Write-Output "Setting $toolAlias as diff/merge tool"

  . $git_exe config --global diff.tool $toolAlias
  . $git_exe config --global diff.guitool $toolAlias
  . $git_exe config --global merge.tool $toolAlias
}

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

$kdiffPath = "$env:ProgramW6432\KDiff3\kdiff3.exe"
$bcPath = "$env:ProgramW6432\Beyond Compare 4\BCompare.exe"
$meldPath = "${env:ProgramFiles(x86)}\Meld\Meld.exe"
$winmergePath = "$env:ProgramW6432\WinMerge\WinMergeU.exe"

. $git_exe config --global difftool.prompt false
. $git_exe config --global mergetool.prompt false

if (Test-Path $kdiffPath)
{
  Write-Output "Found KDiff3 at: $kdiffPath"

  . $git_exe config --global difftool.kdiff3.path "$kdiffPath"
  . $git_exe config --global difftool.kdiff3.keepBackup false
  . $git_exe config --global difftool.kdiff3.trustExitCode false

  . $git_exe config --global mergetool.kdiff3.path "$kdiffPath"
  . $git_exe config --global mergetool.kdiff3.keepBackup false
  . $git_exe config --global mergetool.kdiff3.trustExitCode false
}
if (Test-Path $bcPath)
{
  Write-Output "Found BeyondCompare at: $bcPath"

  . $git_exe config --global difftool.bc.path "$bcPath"
  . $git_exe config --global difftool.bc.keepBackup false
  . $git_exe config --global difftool.bc.trustExitCode false

  . $git_exe config --global mergetool.bc.path "$bcPath"
  . $git_exe config --global mergetool.bc.keepBackup false
  . $git_exe config --global mergetool.bc.trustExitCode false
}
if (Test-Path $meldPath)
{
  Write-Output "Found Meld at: $meldPath"

  . $git_exe config --global difftool.meld.path "$meldPath"
  . $git_exe config --global difftool.meld.keepBackup false
  . $git_exe config --global difftool.meld.trustExitCode false

  . $git_exe config --global mergetool.meld.cmd "'$meldPath' `"`$LOCAL`" `"`$MERGED`" `"`$REMOTE`" --output `"`$MERGED`""
  . $git_exe config --global mergetool.meld.keepBackup false
  . $git_exe config --global mergetool.meld.trustExitCode false
}
if (Test-Path $winmergePath)
{
  Write-Output "Found WinMerge at: $winmergePath"

  . $git_exe config --global difftool.winmerge.cmd "'$winmergePath' -u -e `$LOCAL `$REMOTE"
  . $git_exe config --global difftool.winmerge.keepBackup false
  . $git_exe config --global difftool.winmerge.trustExitCode true

  . $git_exe config --global mergetool.winmerge.cmd "'$winmergePath' -u -e -dl \`"Local\`" -dr \`"Remote\`" `$LOCAL `$REMOTE `$MERGED"
  . $git_exe config --global mergetool.winmerge.keepBackup false
  . $git_exe config --global mergetool.winmerge.trustExitCode true
}

# Tools (in order of preference): KDiff3, BeyondCompare, Meld, WinMerge.
if (Test-Path $kdiffPath)
{
  SetDiffMergeTool 'kdiff3'
}
elseif (Test-Path $bcPath)
{
  SetDiffMergeTool 'bc'
}
elseif (Test-Path $meldPath)
{
  SetDiffMergeTool 'meld'
}
elseif (Test-Path $winmergePath)
{
  SetDiffMergeTool 'winmerge'
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
. $git_exe config --global alias.dt 'difftool --dir-diff'
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
. $git_exe config --global alias.mt 'mergetool'
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
  Write-Output "Set git global username with git config --global user.name 'foo' to use standup"
}
