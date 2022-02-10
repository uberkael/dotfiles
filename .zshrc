# History
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=100000
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
	zdharma-continuum/z-a-as-monitor \
	zdharma-continuum/z-a-patch-dl \
	zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

# autoload compinit
# compinit
zicompinit

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
zinit pack for dircolors-material
# Load trapd00r/LS_COLORS
zinit pack for ls_colors

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
zinit pack"bgn" for fzf

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

zinit load softmoth/zsh-vim-mode

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
	OMZP::command-not-found
	# OMZP::fzf
	# OMZP::zsh-syntax-highlighting \
	# OMZP::zsh-completions \
	# OMZP::fast-syntax-highlighting \

# Buscar Historial
zinit light zsh-users/zsh-history-substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zinit light zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-autosuggestions

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
	if [ -x "$(command -v apt)" ];
	then
		alias aconf='sudo dpkg-reconfigure'
		alias asea='apt search'
		alias alist='apt list --installed'
		alias ainst='sudo apt install -y'
		alias aremo='sudo apt remove -y'
		alias ainfo='apt info'
		alias aup='sudo apt update -y; sudo apt upgrade -y'
		alias aclean='sudo apt autoremove -y; sudo apt clean -y'
		alias agui='sudo -E synaptic'
		# alias apt='sudo apt'
	fi
	if [ -x "$(command -v pacman)" ];
	then
		alias asea='pacman -Ss'
		alias alist='pacman -Q'
		alias ainst='sudo pacman -S'
		alias aremo='sudo pacman -Rs '
		alias ainfo='pacman -Si'
		alias ainfo='pacman -Qi'
		alias aup='sudo pacman -Syu'
		alias aclean='sudo pacman -Qdtq | sudo pacman -Rs -; sudo pacman -Sc'
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
	#########
	# PyEnv #
	#########
	if command -v pyenv 1>/dev/null 2>&1; then
		export PYENV_ROOT="$HOME/.pyenv"
		export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init --path)"
		eval "$(pyenv init -)"
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
	alias aremo='brew remove'
	alias acinst='brew cask install'
	alias acremove='brew cask remove'
	alias ainfo='brew info'
	alias aup='brew update -v;brew upgrade -v;brew cu -vfacy'
	alias aclean='brew cleanup'
	#########
	# PyEnv #
	#########
	if command -v pyenv 1>/dev/null 2>&1; then
		export PYENV_ROOT="$HOME/.pyenv"
		export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init --path)"
		eval "$(pyenv init -)"
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
	alias aremo='choco uninstall'
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
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'
else
	alias ls='lsd 2> /dev/null'
	alias ll='lsd -alF 2> /dev/null'
	alias la='lsd -A 2> /dev/null'
	alias l='lsd -F 2> /dev/null'
fi
# alias grep='grep  -rn --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias chmod='sudo chmod -R'
alias chown='sudo chown -R'
alias chgrp='sudo chgrp -R'
alias rsync='rsync -havPrz --progress'
alias rsyncrm='rsync -havPrz --remove-source-files --progress'
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
alias gcp='dbus-launch gcp -r'
alias cp='cp -R'
alias rm='rm -rf'
alias duh='du -h *'
alias dud='du -h * | sort -h'
alias duf='du -h *|egrep "[.][[:alnum:]]{3,4}$"'
alias weather='curl wttr.in/Sevilla'
alias wea='curl "wttr.in/Sevilla?format=3"'
alias weareport='curl "v2d.wttr.in/Sevilla"'
alias moon='curl wttr.in/Moon'
alias jdk6='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias jdk7='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias jdk8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'
alias suroot='sudo -E -s'
alias ssh='ssh -Y -X'
alias scp='scp -r'
alias testgitlab='ssh -T git@gitlab.ravenpack.com'

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
