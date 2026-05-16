# Dotfiles

Personal dotfiles managed with GNU Stow.

## Fresh setup

Install Homebrew manually first:

Then,

Clone this repo:

```bash
git clone --recurse-submodules git@github.com:vahor/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

If the repo was cloned without submodules:

```bash
git submodule update --init
```

Install Homebrew packages from the Brewfile:

```bash
cd brew
./install
cd ..
```

Then stow the configured packages:

```bash
./install
```

## Shell startup benchmark

Preferred:

```bash
hyperfine 'zsh -i -c exit'
```

Fallback without `hyperfine`:

```bash
for i in {1..10}; do /usr/bin/time -p zsh -i -c exit; done
```

## Adding a new Stow package

1. Create a new package directory in this repo:

   ```bash
   mkdir newapp
   ```

2. Add files using the home-relative layout. For hidden targets, use the target path inside the package:

   ```text
   newapp/.config/newapp/config.toml -> ~/.config/newapp/config.toml
   newapp/.newapp/config             -> ~/.newapp/config
   ```

3. Add the package name to `STOW_FOLDERS` in `init`.

4. Simulate or run stow carefully:

   ```bash
   stow --simulate --dotfiles newapp
   ./install
   ```

## Maintenance checklist

- Before committing, inspect:

  ```bash
  git status --short --ignored
  ```

- Make sure runtime files are ignored rather than tracked.
- For shell changes:

  ```bash
  zsh -n zsh/.zshrc zsh/.zsh_profile
  zsh -df -i -c 'source "$HOME/.dotfiles/zsh/.zshrc"; echo shell-ok'
  ```

- For tmux changes:

  ```bash
  tmux source-file ~/.tmux.conf
  ```

- For Neovim changes:

  ```bash
  nvim --headless +qa
  ```
