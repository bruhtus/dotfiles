# Dotfiles to Restore Configuration

This repo is to backup my linux configuration so that I don't need to configure every new installation (mainly using virtual machine).

### To backup all of your dotfiles config
```bash
git init --bare $HOME/.config
alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'" >> $HOME/.zshrc
```

#### Example command
```bash
config status
config add .zshrc
config commit -m 'Add zshrc'
```

### To restore all of your dotfiles into new system
Install and config zsh, [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh), and [powerlevel10k](https://github.com/romkatv/powerlevel10k) first. And then do this command:
```bash
alias config='/usr/bin/git --git-dir=$HOME/.config/ --work-tree=$HOME'
echo ".config" >> .gitignore
git clone --bare <git-repo-url> $HOME/.config
config checkout
```
There's might be some error while doing `config checkout`. This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git.
The solution is to backup the files if you need them or to remove the files if you don't need them.
After that, you might proceed to `config checkout` again.

Set the flag showUntracedFiles to no on this specific (local) repository by this command:
```bash
config config --local status.showUntrackedFiles no
```
Finally, you're done. You can use `config add dotfiles` to backup new config.

This information was gathered from [here](https://www.atlassian.com/git/tutorials/dotfiles).
