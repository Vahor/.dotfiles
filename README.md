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

Install external Pi skills listed in `agents/external-skills` into `~/.pi/agent/skills/external/`:

```bash
./agents/install-external-skills
```

## Shell startup benchmark

Preferred:

```bash
hyperfine 'zsh -i -c exit'
```

To debug zsh performance, use:

```sh
# in zshrc
zmodload zsh/zprof

...

zprof
```

then run zsh

Perfs as of 2026-05-16:

```
Benchmark 1: zsh -i -c exit
  Time (mean ± σ):     122.0 ms ±   4.9 ms    [User: 61.5 ms, System: 47.0 ms]
  Range (min … max):   112.1 ms … 131.7 ms    23 runs

```

## Nvim startup benchmark

Preferred:

```bash
hyperfine 'nvim -c quitall'
```

then run nvim

Perfs as of 2026-05-16:

```
Benchmark 1: nvim -c quitall
  Time (mean ± σ):     146.1 ms ±   7.5 ms    [User: 114.2 ms, System: 55.9 ms]
  Range (min … max):   133.7 ms … 164.9 ms    20 runs
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
  zsh -n zsh/.zprofile zsh/.zshrc zsh/base.zsh
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
