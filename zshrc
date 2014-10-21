# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vagrant)

source $ZSH/oh-my-zsh.sh

# User configuration

unsetopt autopushd
unsetopt inc_append_history
unsetopt share_history

# This is the usual boot2docker redirect. If it's not available, boot2docker will ask
# that DOCKER_HOST be updated on startup.
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Add Homebrew install location to path.
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

eval "$(rbenv init -)"

alias be="bundle exec"
alias ls="ls -pG"
alias l="ls -al"
alias vi="vim"
alias h="history"
alias cdr="cd ~/puppetlabs"

listvm() { curl --url http://vcloud.delivery.puppetlabs.net/vm 2> /dev/null | ruby -e 'require "json"; JSON.parse(STDIN.read).each { |vm| puts vm }' }
getvm() { curl -d --url http://vcloud.delivery.puppetlabs.net/vm/$1 2> /dev/null | ruby -e 'require "json"; resp = JSON.parse(STDIN.read); puts resp["'$1'"]["hostname"]'}
sshvm() { ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa-acceptance root@$1 "${@:2}" }
rmvm() { curl -X DELETE --url http://vcloud.delivery.puppetlabs.net/vm/$1 }

runmaster () {
        testdir=${1:-.}
	mkdir -p $testdir/master
	mkdir -p $testdir/master/conf/modules
	bundle exec puppet master --autosign=true --no-daemonize --debug --verbose --confdir=$testdir/master/conf --vardir=$testdir/master/var --ca --certname localhost
}
runagent () {
        testdir=${1:-.}
	mkdir -p $testdir/client
	bundle exec puppet agent --no-daemonize --debug --trace --verbose --confdir=$testdir/client/conf --vardir=$testdir/client/var --onetime --server localhost
}

#PROMPT="%h %{%F{magenta}%}%m%{%f%} %{%F{cyan}%}%~%{%f%} %% "

# Optional up/down arrows for search.
#autoload up-line-or-beginning-search
#autoload down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search
#bindkey "^[[B" down-line-or-beginning-search

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Skip forward/back a word with opt-arrow
bindkey ';9C' forward-word
bindkey ';9D' backward-word

# Skip to start/end of line with cmd-arrow
bindkey ';5D' beginning-of-line
bindkey ';5C' end-of-line

# Delete word with opt-backspace/opt-delete
bindkey ';9G' backward-kill-word

# Delete line with cmd-backspace
bindkey ';5I' kill-whole-line

#export PATH="/Users/michaelsmith/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/MacGPG2/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
