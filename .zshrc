# Start profiling zshrc
# zmodload zsh/zprof

################
# ZSH Settings #
################
# No necesita cd
setopt autocd
# enable parameter expansion, command substituion, and arithmetic expansion in prompts
setopt PROMPT_SUBST
# Autocorrect
# setopt correct
# don't beep on an ambiguous completion
setopt no_list_beep
# Permite archivos .
setopt globdots
# Permite comentarios en la linea
setopt interactivecomments

# History
HISTSIZE=100000000
SAVEHIST=100000000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
	command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
		print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
		print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
	zdharma-continuum/z-a-rust \
	zdharma-continuum/z-a-patch-dl \
	zdharma-continuum/zinit-annex-readurl \
	zdharma-continuum/z-a-as-monitor \
	zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

####################
# Install programs #
####################
# ara usar bgn
zinit light zdharma-continuum/zinit-annex-bin-gem-node
# zinit light zdharma-continuum/zinit-annex-readurl
# for id ( ogham/exa sharkdp/{fd,bat} ) {
# 	 zinit from"gh-r" as"program" for @$id
# }
# A cat clone with syntax highlighting and Git integration.
zinit ice from"gh-r" as"program" mv"bat-*/bat -> bat"; zinit light sharkdp/bat
# A viewer for git and diff output
zinit ice from"gh-r" as"program" mv"delta-*/delta -> delta"; zinit light dandavison/delta
# A more intuitive version of du written in rust.
zinit ice from"gh-r" as"program" mv"dust-*/dust -> dust"; zinit light bootandy/dust
# A simple, fast and user-friendly alternative to find
zinit ice from"gh-r" as"program" mv"fd-*/fd -> fd"; zinit light sharkdp/fd
# An extremely fast alternative to grep that respects your gitignore
zinit ice from"gh-r" as"program" mv"ripgrep-*/rg -> rg"; zinit light BurntSushi/ripgrep
############
# Compinit #
############
# autoload compinit
# compinit

# Solo actualiza cada 24 horas
# autoload -Uz compinit
# for dump in ~/.zcompdump(N.mh+24); do
#   compinit
# done
# compinit -C

zicompinit # equals to autoload compinit; compinit

##########
# THEMES #
##########
# Spaceship-prompt
# zinit light denysdovhan/spaceship-prompt

# Zinc
# zinit ice id-as"auto"; zinit light robobenklein/zinc

# Pure
# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'; zinit light sindresorhus/pure

# Powerlevel9k
# zplugin ice from"gh"; zplugin load bhilburn/powerlevel9k

# P10k
zinit ice depth=1;
zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

###########
# PLUGINS #
###########
# Load  zpm-zsh/dircolors-material
[[ "$OSTYPE" != 'cygwin'* ]] && zinit pack for dircolors-material
# Load trapd00r/LS_COLORS
[[ "$OSTYPE" != 'cygwin'* ]] && zinit pack for ls_colors

# zinit light trapd00r/LS_COLORS

# fzf
# zinit ice wait lucid
# zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh
# zinit ice from"gh-r" as "command"
# zinit load junegunn/fzf-bin

# zinit ice from"gh-r" as"program"
# zinit light junegunn/fzf

# Fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# zinit pack for fzf
[[ "$OSTYPE" != 'cygwin'* ]] && zinit pack"bgn" for fzf

# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# fzf tab
zinit light Aloxaf/fzf-tab

# Grc
# source /usr/local/etc/grc.zsh
# source "`brew --prefix grc`/etc/grc.bashrc"
# zinit light garabik/grc
# [[ -s "$GRCPATH" ]] && source $GRCPATHZSH
# TODO
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

# fzy
zinit ice as"command" make"\!PREFIX=$ZPFX install" \
	atclone"cp contrib/fzy-* $ZPFX/bin/" \
	pick"$ZPFX/bin/fzy*"
zinit load jhawthorn/fzy

# Teclas especiales alt flechas home etc
# bindkey -v
# zinit load softmoth/zsh-vim-mode



# Fast Syntax Highlighting
zinit load zdharma-continuum/fast-syntax-highlighting

# plugins=(fzf-tab colored-man-pages fzf git history-substring-search sudo zsh-autosuggestions zsh-completions zsh-syntax-highlighting fast-syntax-highlighting)

# zinit wait lucid for \
# 	OMZL::git.zsh \
# 	OMZL::clipboard.zsh \
# 	OMZL::directories.zsh \
# 	OMZL::grep.zsh \
# 	OMZL::history.zsh \
# 	OMZL::spectrum.zsh \
# 	OMZL::termsupport.zsh \
# 	OMZL::completion.zsh \
# 	OMZP::git \
# 	OMZP::fzf

FZF_BASE=~/software/fzf

zinit wait lucid for \
	OMZL::git.zsh \
	OMZL::clipboard.zsh \
	OMZL::directories.zsh \
	OMZL::grep.zsh \
	OMZL::history.zsh \
	OMZL::spectrum.zsh \
	OMZL::termsupport.zsh \
	OMZL::completion.zsh \
	OMZP::git \
	OMZP::colored-man-pages \
	OMZP::sudo \
	OMZP::pip \
	OMZP::systemd \
	OMZP::fasd \
	OMZP::command-not-found
	# OMZP::fzf
	# OMZP::screen \
	# OMZP::zsh-syntax-highlighting \
	# OMZP::zsh-completions \
	# OMZP::fast-syntax-highlighting \

# Buscar teclas
# showkey -a
# Lista de comandos
# zle -al

# Buscar Historial
zinit light zsh-users/zsh-history-substring-search
[[ "$OSTYPE" != 'darwin'* ]] && bindkey "$terminfo[kcuu1]" history-substring-search-up
[[ "$OSTYPE" != 'darwin'* ]] && bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Move with arrows
# Ctrl
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
# Alt
bindkey '^[[1;3C' emacs-forward-word
bindkey '^[[1;3D' emacs-backward-word
bindkey '^[[1;4C' emacs-forward-word
bindkey '^[^[[C' emacs-forward-word
bindkey '^[[1;4D' emacs-backward-word
bindkey '^[^[[D' emacs-backward-word

# Home
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line

bindkey "\E[H" beginning-of-line
bindkey "\E[F" end-of-line
bindkey "\E[3~" delete-char

# for rxvt (Home End)
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# Clear
bindkey '^[[3;5~' kill-whole-line

# Delete
bindkey '^H' backward-kill-word # Ctrl
bindkey '^[[3;3~' kill-line

# zinit light zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-autosuggestions
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# More completions
# zinit light zsh-users/zsh-completions
zinit ice wait'0' lucid; zinit light sainnhe/zsh-completions

# Autocomplete lista mientras escribes
# zinit light marlonrichert/zsh-autocomplete

# Fish man
# load module for list-style selection
# zmodload zsh/complist
# setopt menucomplete
# zstyle ':completion:*' menu select=0 search
# zstyle ':completion:*:manuals'    separate-sections true
# zstyle ':completion:*:manuals.*'  insert-sections   true
# zstyle ':completion:*:man:*'      menu yes select

# Genera autocompletado con manpages
# gencomp fzf --man
# gencomp bat
# zinit light Aloxaf/gencomp

# zinit light RobSis/zsh-completion-generator
# zstyle :plugin:zsh-completion-generator programs ggrep tr cat pyenv

# alias reminders
zinit light "djui/alias-tips"

# Pyenv
# zinit pack for pyenv
# zinit light zdharma-continuum/zinit-annex-bin-gem-node
# zinit pack"bgn" for pyenv

# Url quotes magic
if [ $TERM = "xterm-256color" ]; then
	# Then load url-quote-magic and bracketed-paste-magic as above
	autoload -U url-quote-magic bracketed-paste-magic
	zle -N self-insert url-quote-magic
	zle -N bracketed-paste bracketed-paste-magic
	# Now the fix, setup these two hooks:
	pasteinit() {
		OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
		zle -N self-insert url-quote-magic
	}
	pastefinish() {
		zle -N self-insert $OLD_SELF_INSERT
	}
	zstyle :bracketed-paste-magic paste-init pasteinit
	zstyle :bracketed-paste-magic paste-finish pastefinish
	# and finally, make sure zsh-autosuggestions does not interfere with it:
	ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
fi

######
# OS #
######
case "$OSTYPE" in
	linux*)
	GRCPATH="/usr/bin/grc"
	GRCPATHZSH="/etc/grc.zsh"
	alias ls='grc --colour=auto ls --color'
	alias ipa='grc --colour=auto ip address'
	alias ipr='grc --colour=auto ip route'
	alias ip='grc --colour=auto ip'
	alias sbcl='rlwrap sbcl'
	alias alisp='rlwrap alisp'
	alias ccl='rlwrap ccl'
	alias clasp='rlwrap clasp'
	alias open="xdg-open"
	if [ -x "$(command -v apt)" ];
	then
		alias aconf='sudo dpkg-reconfigure'
		alias asea='apt search'
		alias alist='apt list --installed'
		alias ainst='sudo apt install -y'
		alias arm='sudo apt remove -y'
		alias ainfo='apt info'
		alias aup='sudo apt update -y; sudo apt upgrade -y'
		alias aclean='sudo apt autoremove -y; sudo apt clean -y'
		alias agui='sudo -E synaptic'
		alias afresh='sudo apt update -y'
		alias amirror='netselect-apt -n'
		# alias apt='sudo apt'
	fi
	if [ -x "$(command -v pacman)" ];
	then
		alias asea='pacman -Ss'
		alias alist='pacman -Q'
		alias ainst='sudo pacman -S'
		alias arm='sudo pacman -Rs '
		alias ainfo='pacman -Si'
		alias ainfo='pacman -Qi'
		alias aup='sudo pacman -Syu'
		alias aclean='sudo pacman -Qdtq | sudo pacman -Rs -; sudo pacman -Sc'
		alias afresh='sudo pacman -Syy'
		alias amirror='sudo pacman-mirrors -f'
		# TODO
		alias apack='pacman -Ql'
		alias agui='sudo -E /usr/bin/pamac-manager'
	fi
	if [ -x "$(command -v systemctl)" ];
	then
		service() {
			if [ -n "$1" ] && [ -n "$2" ]
			then
				sudo systemctl "$2" "$1"
			else
				echo "service <servicio> <accion>"
			fi
		}
		alias systemctl='sudo systemctl'
	fi
	# #########
	# # PyEnv #
	# #########
	export PYENV_ROOT="$HOME/.pyenv"
	if [ -x "$(command -v pyenv)" ];
	then
		export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init --path)"
		eval "$(pyenv init -)"
		eval "$(pyenv virtualenv-init -)"
		source /home/kael/.zinit/plugins/pyenv/completions/pyenv.zsh
	fi
	;;
	darwin*)
	# Brew plugins
	# fpath=(/usr/local/share/zsh-completions $fpath)
	# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	# source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	# source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
	# Colores de ls
	GRCPATH="/usr/local/etc/grc.zsh"
	GRCPATHZSH="/usr/local/etc/grc.zsh"
	export CLICOLOR=1
	export LSCOLORS="ExFxCxDxBxegedabagacad"
	# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxc
	# export LSCOLORS="GxFxCxDxBxegedabagaced"
	# export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
	alias sbcl='rlwrap sbcl'
	alias alisp='rlwrap alisp'
	alias ccl='rlwrap ccl'
	alias clasp='rlwrap clasp'
	alias imgcat=~/.iterm2/imgcat
	alias imgls=~/.iterm2/imgls
	alias it2attention=~/.iterm2/it2attention
	alias it2check=~/.iterm2/it2check
	alias it2copy=~/.iterm2/it2copy
	alias it2dl=~/.iterm2/it2dl
	alias it2getvar=~/.iterm2/it2getvar
	alias it2setcolor=~/.iterm2/it2setcolor
	alias it2setkeylabel=~/.iterm2/it2setkeylabel
	alias it2ul=~/.iterm2/it2ul
	alias it2universion=~/.iterm2/it2universion
	alias java_home="/usr/libexec/java_home -V"
	alias ls='grc --colour=auto ls'
	alias ipa='grc --colour=auto ip address'
	alias asea='brew search'
	alias alist='brew list'
	alias ainst='brew install'
	alias arm='brew remove'
	alias acinst='brew install --cask'
	alias acremove='brew cask remove'
	alias ainfo='brew info'
	alias aup='brew update -v;brew upgrade -v;brew cu -vfacy'
	alias aclean='brew cleanup'
	# #########
	# # PyEnv #
	# #########
	export PYENV_ROOT="$HOME/.pyenv"
	if [ -x "$(command -v pyenv)" ];
	then
		export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init --path)"
		eval "$(pyenv init -)"
		eval "$(pyenv virtualenv-init -)"
	fi
	;;
	cygwin*)
	# PATH=/cygdrive/c/Portable/Python/:$PATH
	GRCPATH="/usr/local/bin/grc"
	GRCPATHZSH="/etc/grc.zsh"
	alias ls='ls --color'
	alias netstat='grc netstat'
	alias ping='grc ping'
	alias traceroute='grc tracert'
	alias asea='choco list'
	alias alist='choco list -l'
	alias ainst='cinst'
	alias arm='choco uninstall'
	alias ainfo='choco info'
	alias aup='cup'
	alias aclean='/cygdrive/c/ProgramData/chocolatey/bin/choco-cleaner.bat'
	alias pyenv='cmd /c "pyenv"'
	alias python='cmd /c "python"'
	;;
esac

###############
# Alias Comun #
###############
if ! command -v lsd &> /dev/null; then
	alias l='ls -CF'
	alias la='ls -A'
	alias ll='ls -alF'
else
	alias l='lsd -F 2> /dev/null'
	alias la='lsd -A 2> /dev/null'
	alias ll='lsd -alF 2> /dev/null'
	alias ls='lsd 2> /dev/null'
fi
# alias grep='grep  -rn --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias chgrp='sudo chgrp -R'
alias chmod='sudo chmod -R'
alias chown='sudo chown -R'
alias cp='cp -R'
# alias docker-compose='sudo docker-compose'
# alias docker='sudo docker'
alias dud='du -h * | sort -h'
alias duf='du -h *|egrep "[.][[:alnum:]]{3,4}$"'
alias duh='du -h *'
alias gcp='dbus-launch gcp -r'
alias jdk6='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias jdk7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias jdk8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
alias moon='curl wttr.in/Moon'
alias rm='rm -rf'
alias rsync='rsync -havPrz --progress'
alias rsyncrm='rsync -havPrz --remove-source-files --progress'
alias scp='scp -r'
alias ssh='ssh -Y -X'
alias suroot='sudo -E -s'
alias testgitlab='ssh -T git@gitlab.ravenpack.com'
alias tmux='tmux a || tmux'
alias screen='screen -x || screen'
alias wea='curl "wttr.in/Sevilla?format=3"'
alias weareport='curl "v2d.wttr.in/Sevilla"'
alias weather='curl wttr.in/Sevilla'
alias ps='grc ps'
alias ping='grc ping'
alias myip='curl http://ipecho.net/plain; echo'
alias distro='cat /etc/*-release'


#############
# Functions #
#############
# Take crea y entra a un directorio
take() {
	mkdir -p "$1" && cd "$1"
}

#####################
# Exports Ravenpack #
#####################
export RP_REPOS=$HOME/git
#export RP_REPOS=/mnt/ram/git
export PATH=$PATH:/opt/acl10.1-smp.64
export ACL_LOCALE=C.latin1
export NLS_LANG=AMERICAN.WE8ISO8859P1
export ORACLE_HOME=/opt/oracle/product/11.2.0.3/client_1/lib
export LD_LIBRARY_PATH=$ORACLE_HOME:/usr/lib/x86_64-linux-gnu
export TNS_ADMIN=$RP_REPOS/configuration
export IFILE=$TNS_ADMIN/tnsnames.ora

PATH=.:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/X11/bin:/usr/local/sbin:$PATH

[[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

##########
# Zstyle #
##########
# Colores de ls en autocompletado de archivos
# disable-fzf-tab
# zstyle ':completion:*' list-colors '=(#b)(--[^ ])(*)=38;5;220;1=38;5;216'
# zstyle ':completion:*' file-list true
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# Partial pattern matching https://unix.stackexchange.com/q/168741/354135
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# zstyle ':completion:*' matcher-list 'r:|?=**'

#######
# fzf #
#######
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_OPTS='--layout=reverse --border'

###########
# fzf tab #
###########
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Agrega el minimo
zstyle ':fzf-tab:*' fzf-pad 40
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# Tmux buffer
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# Preview
# variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
# SystemD status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
# Accept selected demasiado fuerte
#  zstyle ':fzf-tab:*' accept-line space
# Hosts
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Fast trigger
# Acepta el path inmediatamente
# zstyle ':fzf-tab:*' continuous-trigger '/'

# Format
zstyle ':fzf-tab:*' prefix ''

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

###############
# Go To Every #
###############
## use rg to get file list
export FZF_DEFAULT_COMMAND='rg --files --hidden'

## file open (function1)
__my-fo() (
  setopt localoptions pipefail no_aliases 2> /dev/null
  local file=$(eval "${FZF_DEFAULT_COMMAND}" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS --preview 'bat --color=always --line-range :500 {}'" fzf -m "$@" | while read item; do
	echo -n "${(q)item}"
  done)
  local ret=$?
  if [[ -n $file ]]; then
	echo "$EDITOR"
	# $EDITOR $file
	echo "$file"
  fi
  return $ret
)

## define zsh widget(function2)
__my-fo-widget(){
  __my-fo
  local ret=$?
  zle reset-prompt
  return $ret
}

zle -N __my-fo-widget
bindkey ^p __my-fo-widget

# Alternativa
zbenchmark () {
	for i in $(seq 1 10); do time zsh -i -c exit; done
}
# Stop profiling zshrc - bottom of .zshrc
# zprof

# History duplicates
h() {
	if [ -z "$*" ]; then
		history 1;
	else history 1 | egrep "$@"; fi;
}
# Load .env
env-load() {
	# if [ -f .env ]; then
	#   export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
	# fi
	# [ ! -f .env ] || export $(grep -v '^#' .env | xargs | envsubst)
	[ ! -f .env ] || export $(sed 's/#.*//g' .env | xargs | envsubst)
}

# Docker ips
docker-ips() {
	docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
}
