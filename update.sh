#!/usr/bin/env zsh

echo -e "\e[0m\e[31mUpgrading Prezto\e[0m"
currentdir=$PWD
cd $HOME/.zprezto
git pull && git submodule update --init --recursive
cd $currentdir

echo -e "\e[31mUpdating MacPorts port listing\e[0m"
port selfupdate

echo -e "\e[31mUpgrading MacPorts ports\e[0m"
port upgrade outdated

echo -e "\e[31mUninstalling inactive MacPorts ports\e[0m"
port uninstall inactive

echo -e "\e[31mUpgrading vim plugins\e[0m"
vim -c ':PlugUpgrade | :PlugUpdate | :q! | :q!'

echo -e "\e[31mUpgrade tmux plugins manually <C-a>U all\e[0m"
