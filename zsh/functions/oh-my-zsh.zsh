# OMZ is slow, so we only load what we need

# ZSH settings
WORDCHARS=''
setopt menu_complete
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*:*:*:*:*' menu select
zmodload zsh/complist
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

bindkey -M menuselect '^[[Z' reverse-menu-complete
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# ZSH plugins
# The idea is to download the plugins with brew, and then load them manually
# plugins=(zsh-autosuggestions zsh-syntax-highlighting)
# prefix=$(brew --prefix)
prefix="/opt/homebrew"
source $prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
