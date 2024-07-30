# Source zsh-async
source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-async/async.zsh"

# Initialize async worker
async_init
async_start_worker async_worker -n

# Callback function to handle the result of compinit
async_register_callback async_worker handle_compinit() {
    # Actions after compinit, if needed
}

# Load compinit asynchronously
async_job async_worker compinit -C

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme and plugins
ZSH_THEME="crunch"
DISABLE_AUTO_UPDATE="true"
plugins=(git)

# Export PATH
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH:$HOME/.yarn-global/bin"

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom Aliases
alias hg="history | grep"
alias tcp="tree -I 'node_modules|.git|*.log|target|build|dist|*.lock|Pods' -L 3 | pbcopy"
alias .="nvim"
alias zshconfig="nvim ~/.zshrc"

# Git aliases
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gca="git commit --amend --no-edit"
alias gcb="git checkout -b"
alias gp='if ! git config remote.origin.url > /dev/null; then git remote add origin git@github.com:yourusername/trustystack-frontend.git; fi; git push origin $(git symbolic-ref --short HEAD)'
alias gg='git checkout -'
alias gcm='git checkout main'
alias br='git branch -a'
alias so='source ~/.zshrc'

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Angular CLI autocompletion asynchronously
async_job async_worker source <(ng completion script)

