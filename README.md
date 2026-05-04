https://starship.rs/

fzf search terminal history


Append this line to ~/.zshrc to enable fzf keybindings for Zsh:

   source /usr/share/doc/fzf/examples/key-bindings.zsh

## Adding a new configuration folder

To add a new configuration directory (e.g., `newapp/`) to this dotfiles repository and have it automatically symlinked via `stow`:

1. **Create the directory** in the root of this repo:
   ```bash
   mkdir newapp
   ```
2. **Add your configuration files** inside that directory.
   * **Note for hidden directories**: If you want to symlink to a hidden directory in `$HOME` (e.g., `~/.pi`), place the contents inside a subdirectory named after the target (e.g., `newapp/.newapp/`).
3. **Update the `init` script** to include the new folder name in `STOW_FOLDERS`:
   ```bash
   # Edit 'init' and add 'newapp' to the comma-separated list
   export STOW_FOLDERS="...,newapp"
   ```
4. **Run the install script**:
   ```bash
   ./install
   ```

This will use `stow` to symlink the contents of `newapp/` into your home directory (or wherever configured).
