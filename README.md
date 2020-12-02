# Dotfiles to Restore Configuration

This repo is to backup my linux configuration so that I don't need to configure every new installation (mainly using virtual machine). You can use the command below to backup and restore your dotfiles config.

### Initialize dotbare to backup configuration dotfiles
```bash
dotbare finit
```

#### Example command
```bash
dotbare status
dotbare add .zshrc
dotbare commit -m 'Add zshrc'
dotbare push origin master
```

### To restore all of your dotfiles into new system
Install and config zsh, [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh), and [powerlevel10k](https://github.com/romkatv/powerlevel10k) first. And then do this command:

#### Add dotbare to oh-my-zsh
- Clone dotbare repository to oh-my-zsh plugins directory using the command below:
```bash
git clone https://github.com/kazhala/dotbare.git $HOME/.oh-my-zsh/custom/plugins/dotbare
```
- Activate the plugin in `~/.zshrc`, for example:
```bash
plugins=(git dotfiles) #There are 2 plugins, git plugin and dotbare plugin
```
- Restart the terminal (exit terminal and open it again).

#### Initialize dotbare in new system
```bash
dotbare finit -u <git-repo-url>
```

Check out the [wiki](https://github.com/bruhtus/dotfiles/wiki) for more stuff.

This informations were gathered from:
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
- [DistroTube dotbare blog](https://www.distrotube.com/blog/interactive-dotfiles-management-with-dotbare/).
- [Dotbare github repo](https://github.com/kazhala/dotbare).
