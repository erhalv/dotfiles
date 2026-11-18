# dotfiles
Commands
```
    mkdir -p "~/.config/i3"
    mkdir -p "~/.config/tmux"
    ln -sfn ~/dotfiles/i3/config ~/.config/i3/config
    ln -sfn ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
    ln -sfn ~/dotfiles/bash/.bashrc ~/.bashrc
    ln -sfn ~/dotfiles/scripts ~/.config/scripts
    cp ~/dotfiles/system/keyboard /etc/default/keyboard
```
Turn of menubar default terminal ubuntu
```
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
```

