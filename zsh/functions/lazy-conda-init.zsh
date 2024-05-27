# https://www.reddit.com/r/zsh/comments/qmd25q/lazy_loading_conda/

lazy_conda_aliases=('python' 'conda')
# Lazy load conda initialization
_lazy_conda_init() {
  for lazy_conda_alias in $lazy_conda_aliases
  do
    unalias $lazy_conda_alias
  done

  __conda_prefix="/opt/homebrew/anaconda3"

  # >>> conda initialize >>>
  __conda_setup="$("$__conda_prefix/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "$__conda_prefix/etc/profile.d/conda.sh" ]; then
          . "$__conda_prefix/etc/profile.d/conda.sh"
      else
          export PATH="$__conda_prefix/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  unset __conda_prefix
  unfunction _lazy_conda_init
}

for lazy_conda_alias in $lazy_conda_aliases
do
  alias $lazy_conda_alias="_lazy_conda_init && $lazy_conda_alias"
done
