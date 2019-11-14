This repository is my Ubuntu 18.04 installation script.

Steps:
0. Add W+E to open File Explorer as in Windows  
   (Settings -> Devices -> Keyboard -> Home Folder = Super + E)
1. mkdir setup_ubuntu && cd setup_ubuntu  
   wget https://codeload.github.com/lamductan/setup_ubuntu/zip/master -O setup_ubuntu.zip  
   unzip setup_ubuntu.zip && cd setup_ubuntu_master
2. bash 2_init.sh
3. source ~/.bashrc
4. bash 4_install_packages.sh
5. Restart the shell (close all shells, then logout and login again)
6. bash 6_config_zsh_vim_tmux.sh

## If personal: visual code, sublime-text, google-chrome, slack, skype, foxit-reader, acrobat-reader, geany
7. bash 7_install_softwares.sh
