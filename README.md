# Dotfiles to Restore Configuration

This repo is to backup my linux configuration so that I don't need to configure every new installation (mainly using virtual machine).

### Initialize dotbare
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
```bash
dotbare finit -u <git-repo-url>
```

This information was gathered from:
- [Atlassian tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
- [DistroTube dotbare blog](https://www.distrotube.com/blog/interactive-dotfiles-management-with-dotbare/).
- [Dotbare github repo](https://github.com/kazhala/dotbare).
