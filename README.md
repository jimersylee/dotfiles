# README

clone to any folder

install brew and install stow

```shell
#use brew to install my default app
brew bundle --file ./brew/.config/Brewfile

```
```shell
cd /path/to/dotfiles
stow -t $HOME .

```
if you just want to configure one program like karabiner
```shell
cd /path/to/dotfiles
stow karabiner -t ~


```
