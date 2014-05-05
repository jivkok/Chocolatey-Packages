$package = 'jivkok.GitConfig'

try {
  # inspired by
  # https://git.wiki.kernel.org/index.php/Aliases
  # https://gist.github.com/bradwilson/4215933
  # https://gist.github.com/oli/1637874

  # Prereqs
  setx TERM msys /M
  $kdiffPath = "$env:ProgramW6432\KDiff3\kdiff3.exe"
  if (Test-Path $kdiffPath) { Write-Output "Found '$kdiffPath'" } else { Write-Warning "Could not find '$kdiffPath'" }

  # Core
  git config --global core.autocrlf true
  git config --global core.safecrlf false
  $defaultEditor = git config --get core.editor
  if (!$defaultEditor)
  {
      git config --global core.editor notepad
  }
  git config --global help.format html
  git config --global pack.packSizeLimit 2g
  git config --global push.default simple
  git config --global rebase.autosquash true

  # Colors
  git config --global color.branch.current "red bold"
  git config --global color.branch.local normal
  git config --global color.branch.remote "yellow bold"
  git config --global color.branch.plain normal
  git config --global color.diff.meta "yellow bold"
  git config --global color.diff.frag "magenta bold"
  git config --global color.diff.old "red bold"
  git config --global color.diff.new "green bold"
  git config --global color.status.header normal
  git config --global color.status.new "red bold"
  git config --global color.status.added "green bold"
  git config --global color.status.updated "cyan bold"
  git config --global color.status.changed "cyan bold"
  git config --global color.status.untracked "red bold"
  git config --global color.status.nobranch "red bold"

  # Diff & Merge
  if (Test-Path $kdiffPath)
  {
    git config --global diff.tool kdiff3
    git config --global diff.guitool kdiff3
    git config --global difftool.prompt false
    git config --global difftool.kdiff3.path "$kdiffPath"
    git config --global difftool.kdiff3.keepBackup false
    git config --global difftool.kdiff3.trustExitCode false

    git config --global merge.tool kdiff3
    git config --global mergetool.prompt false
    git config --global mergetool.kdiff3.path "$kdiffPath"
    git config --global mergetool.kdiff3.keepBackup false
    git config --global mergetool.kdiff3.trustExitCode false
  }

  # Aliases
  git config --global alias.a 'add -A'
  git config --global alias.aliases 'config --get-regexp alias'
  git config --global alias.amend 'commit --amend -C HEAD'
  git config --global alias.bl 'blame -w -M -C'
  git config --global alias.br 'branch'
  git config --global alias.bra 'branch -rav'
  git config --global alias.branches 'branch -rav'
  git config --global alias.cat 'cat-file -t'
  git config --global alias.ci 'commit -a'
  git config --global alias.changed 'status -sb'
  git config --global alias.cm 'commit -m'
  git config --global alias.co 'checkout'
  git config --global alias.df 'diff --word-diff=color --word-diff-regex=. -w --patience'
  git config --global alias.dump 'cat-file -p'
  git config --global alias.f '! git ls-files | grep -i'
  git config --global alias.filelog 'log -u'
  git config --global alias.hist "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue) [%an]%Creset' --abbrev-commit --date=relative"
  git config --global alias.in 'log --pretty=format:\"%h %ad | %s%d [%an]\" --date=short ..@{u}'
  git config --global alias.l 'log --pretty=format:\"%h %ad | %s%d [%an]\" --date=short'
  git config --global alias.last 'log -p --max-count=1 --word-diff'
  git config --global alias.lastref 'rev-parse --short HEAD'
  git config --global alias.lasttag 'describe --tags --abbrev=0'
  git config --global alias.lg 'log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short'
  git config --global alias.loglist 'log --oneline'
  git config --global alias.out 'log --pretty=format:\"%h %ad | %s%d [%an]\" --date=short @{u}..'
  git config --global alias.pick 'add -p'
  git config --global alias.pullom 'pull origin master'
  git config --global alias.pushom 'push origin master'
  git config --global alias.re 'rebase'
  git config --global alias.reabort 'rebase --abort'
  git config --global alias.rego 'rebase --continue'
  git config --global alias.reskip 'rebase --skip'
  git config --global alias.remotes 'remote -v show'
  git config --global alias.st 'status -sb'
  git config --global alias.stats 'diff --stat'
  git config --global alias.stage 'add'
  git config --global alias.stats 'diff --stat'
  git config --global alias.undo 'reset head~'
  git config --global alias.unstage 'reset HEAD'
  git config --global alias.wdiff 'diff --word-diff'
  git config --global alias.who 'shortlog -s -e --'
  $userName = git config --global --get user.name
  if ($userName)
  {
    git config --global alias.standup "log --since yesterday --oneline --author $userName"
  }
  else
  {
    Write-Warning "Set git global username with git config --global user.name 'foo' to use standup"
  }

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
