#!/usr/bin/env zsh

echo -e "\e[31mUpgrading oh-my-zsh\e[0m"
/usr/bin/env sh $ZSH/tools/upgrade.sh

echo -e "\e[31mUpdating MacPorts port listing\e[0m"
sudo port selfupdate

echo -e "\e[31mUpgrading MacPorts ports\e[0m"
sudo port upgrade outdated

echo -e "\e[31mUninstalling inactive MacPorts ports\e[0m"
sudo port uninstall inactive

echo -e "\e[31mUpgrading vim plugins\e[0m"
vim -c ':PlugUpgrade | :PlugUpdate | :q! | :q!'

echo -e "\e[31mUpgrade tmux plugins manually <C-a>U all\e[0m"
