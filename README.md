# This repository is my Ubuntu 18.04 installation script.

## Steps:  
0. Add Super + E to open File Explorer as in Windows  
   (Settings -> Devices -> Keyboard -> Home Folder = Super + E)  
   Never logout when inactive  
   (Settings -> Power -> Blank screen : Never,  
    Settings -> Power -> Automatic suspend : Off,  
    Settings -> Privacy -> Screen Lock : Off)
1. mkdir setup_ubuntu && cd setup_ubuntu  
   wget https://codeload.github.com/lamductan/setup_ubuntu/zip/master -O setup_ubuntu.zip  
   unzip setup_ubuntu.zip && cd setup_ubuntu-master
2. bash 2_init.sh
3. source ~/.bashrc
4. bash 4_install_packages.sh
5. Log out and log in again.

## If personal: visual code, sublime-text, google-chrome, slack, skype, foxit-reader, acrobat-reader, geany
7. bash 7_install_softwares.sh

## Note:
1. Unresolved bug: After step 5, run this command to install go-langserver:  
   go get -u github.com/sourcegraph/go-langserver
3. In the first time run vim, please run these below commands:  
   :PlugUpdate  
   :CocInstall coc-python coc-tsserver coc-json coc-html coc-css
3. If there is an error when installing a package, add these lines to the correct script to create a block comment
   with successfully installed packages:  
     : <<'IGNORED_PACKAGES'  
     ###code to install packages  
     IGNORED_PACKAGES
4. To check a package with pkgconfig, use command:  
     pkg-config --modversion <package-name>   
   
