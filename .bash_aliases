alias vim="nvim"
alias vi="nvim"
alias copy="xclip -sel clip"
alias ll='eza --icons -l -g -a --group-directories-first'
alias c='clear'
alias bs='exec bash'
alias zs='exec zsh'
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../../..;pwd'
alias ~="cd ~"
alias size='du -sh * | sort -h -r | head -n10'
alias cat="bat"

alias killall='docker kill $(docker ps -q)'
alias killport='_killport() { fuser -k $1/tcp; }; _killport'
alias killhost='sh $HOME/dotfiles/zsh_scripts/killhost.sh'

alias gb='git checkout -b'
alias ga='git add'
alias gaa='git add -A && gs'
alias graph='git log --graph --pretty="%C(auto)%h %d %s %C(yellow)%an %C(white)(%ad)" --decorate --date=relative --all'
alias gf='git fetch'
alias gp='git pull'
alias yolo="git add -A && git commit --amend --no-edit && git push --force-with-lease"
alias filediff='git diff --name-only HEAD origin/master'
alias top='btm  --process_memory_as_value -b -m'
