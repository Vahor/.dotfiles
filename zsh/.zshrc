source $HOME/.dotfiles/zsh/.zsh_profile
export DOTFILES=$HOME/.dotfiles

export PNPM_HOME="/Users/nathan/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="/Users/nathan/.bun/bin:$PATH"

eval "$(starship init zsh)"

source $HOME/.dotfiles/zsh/functions/lazy-conda-init.zsh
source $HOME/.dotfiles/zsh/functions/oh-my-zsh.zsh
source $HOME/.dotfiles/zsh/functions/gh-copilot-alias.zsh

# https://mise.jdx.dev/getting-started.html
eval "$(mise activate zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://direnv.net/
eval "$(direnv hook zsh)"

# https://github.com/rupa/z
prefix=$(brew --prefix)
source $prefix/etc/profile.d/z.sh

# bun completions
[ -s "/Users/nathan/.bun/_bun" ] && source "/Users/nathan/.bun/_bun"

# Pulumi esc
# eval "$(esc completion zsh)"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
export PATH="$HOME/.spin/bin:$PATH"

if [ -z "$TMUX" ]
then
    tmux attach -t default || tmux new -s default
fi

