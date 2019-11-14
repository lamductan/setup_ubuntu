#!/bin/bash
mkdir $HOME/.tmp
wget "https://www.dropbox.com/sh/1bowihot6muvopb/AACyEAJceFCUAdSFv7RPO48ma?dl=0" -O utils/archives.zip
unzip utils/archives.zip -d utils/archives
cp utils/dotfiles/bashrc $HOME/.bashrc
bash utils/gen_gen_pugixml_pkgconfig.sh
bash utils/config_path.sh
