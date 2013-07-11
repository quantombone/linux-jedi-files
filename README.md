This repository contains my dotfiles/customization-files for ***nix** systems (macbooks and linux servers).

![](https://github.com/quantombone/linux-jedi-files/raw/master/screenshots/screenshot-terminal1.png)

I should also take the time to describe my computing environment, which uses lots of terminals, lots of emacs, and vnc/fluxbox on my developmant machines

To install these scripts do the following
``` sh
git clone git@github.com:quantombone/linux-jedi-files.git
cd ~/linux-jedi-files/
```

The issue the following command which will create symlinks for .emacs, .screenrc, .zshrc, and .dircolors
WARING: make sure you backup your config files
``` sh
./make_alias_script.sh
```

## Core *nix programs:
 * ZSH: I use zsh, instead of bash, which lets me use escape sequences to talk to my screen sessions.
 * GNU Screen: this lets me work on remote machines, and is useful for spawning remote jobs on a cluster.
 * Emacs: I am a hardcore emacs nerd. I can't even tell you all the keybindings which my fingers have memorized, but damn I'm fast. (see my .emacs file)

## Emacs
 * I heavily use Emacs, in both window mode "emacs -nw" as well as a Carbo-based Emacs on my Macbooks.  I run a shell "M-x shell" inside emacs, where I then run Matlab inside this shell.

## Desktop:
Fluxbox@Work, MacOSX@Home/Laptop

## Types of computers I use my linux-jedi-files on:
Macbook Pro, Macbook Air, iMac, Linux Machines, Datacenters

## Note for Apple Machines
It is a good idea to get MacPorts and "sudo port install coreutils" to get gls working

--Tomasz Malisiewicz (malist@gmail.com)
