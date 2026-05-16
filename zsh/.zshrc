source "$HOME/.dotfiles/zsh/.zsh_profile"
export DOTFILES="$HOME/.dotfiles"

export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE="${HOMEBREW_NO_AUTO_UPDATE:-1}"

eval "$(starship init zsh)"

zsh_functions="$HOME/.dotfiles/zsh/functions"
source_if_exists "$zsh_functions/lazy-conda-init.zsh"
source_if_exists "$zsh_functions/oh-my-zsh.zsh"
source_if_exists "$zsh_functions/gh-copilot-alias.zsh"
unset zsh_functions

# https://mise.jdx.dev/getting-started.html
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if [[ -t 0 && -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# https://direnv.net/
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# https://github.com/rupa/z
if command -v brew >/dev/null 2>&1; then
  z_profile="$(brew --prefix)/etc/profile.d/z.sh"
  [ -f "$z_profile" ] && source "$z_profile"
  unset z_profile
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Pulumi esc
# eval "$(esc completion zsh)"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
export PATH="$HOME/.spin/bin:$PATH"

if [[ -z "$TMUX" && -z "$ZSH_EXECUTION_STRING" ]] && command -v tmux >/dev/null 2>&1; then
  tmux new-session -A -s default
fi
