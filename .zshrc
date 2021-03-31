# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Determine if current working directory is a git repository
git_branch_color() {
  if current_git_status=$(git status 2> /dev/null); then
    parse_git_dirty
  else
    echo ""
  fi
}

# Change branch color if working tree is clean
parse_git_dirty() {
  if current_git_status=$(git status | grep 'Changes to be committed:\|Untracked files:\|modified:|deleted:' 2> /dev/null); then
    echo "%F{red}"
  else
    echo "%F{green}"
  fi
} 

#aliases
alias glog='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias gs='git status'
alias gp='git push origin head'
alias gpull='git pull'
alias ga='git add .'
alias gac='git add $PWD'
alias gr='git restore --staged .'
alias gf='git commit --amend .'
alias gc='git commit -m'
alias gcb='git checkout'
alias gcm='git checkout main'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{magenta}%d $(git_branch_color)${vcs_info_msg_0_} %f$'

export PATH="/Applications/Postgres.app/Contents/Versions/13/bin:$PATH"

# added by travis gem
[ ! -s /Users/bdizzle/.travis/travis.sh ] || source /Users/bdizzle/.travis/travis.sh
