#!/bin/bash
mkdir $HOME/.tmp
curl "https://www.dropbox.com/sh/1bowihot6muvopb/AACyEAJceFCUAdSFv7RPO48ma?dl=0" -L > utils/archives.zip
unizp utils/archives.zip -d utils/archives
cp utils/dotfiles/bashrc $HOME/.bashrc
bash utils/config_path.sh
