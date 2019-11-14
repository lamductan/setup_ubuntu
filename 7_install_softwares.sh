# Common
pwd=$PWD
LOCAL_DIR=$HOME/.local
SOURCE_DIR=$HOME/Downloads/sources
PROGRAM_DIR=$HOME/Downloads/programs
PACKAGE_DIR=$HOME/packages
OPT_DIR=$LOCAL_DIR/opt
APP_DIR=$LOCAL_DIR/share/applications
DIRECTORY=$(cd `dirname $0` && pwd)

### Google chrome
wget http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_78.0.3904.87-1_amd64.deb --no-check-certificate -O $SOURCE_DIR/google-chrome-stable_78.0.3904.87-1_amd64.deb
dpkg -x $SOURCE_DIR/google-chrome-stable_78.0.3904.87-1_amd64.deb $LOCAL_DIR
ln -s $LOCAL_DIR/opt/google/chrome/chrome $LOCAL_DIR/bin/chrome
chmod +x $LOCAL_DIR/bin/chrome
cp $LOCAL_DIR/opt/google/chrome/product_logo_256.png $HOME/.local/share/icons/chrome.png
cp $DIRECTORY/utils/desktop/chrome.desktop $APP_DIR
chmod a+x $APP_DIR/chrome.desktop
cd $HOME
xdg-settings set default-web-browser chrome.desktop

### vscode
curl https://az764295.vo.msecnd.net/stable/86405ea23e3937316009fc27c9361deee66ffbf5/code_1.40.0-1573064499_amd64.deb -o $PROGRAM_DIR/code_1.40.0-1573064499_amd64.deb
dpkg -x $PROGRAM_DIR/code_1.40.0-1573064499_amd64.deb $LOCAL_DIR
ln -s $LOCAL_DIR/usr/share/code/code $LOCAL_DIR/bin/code
cp $DIRECTORY/utils/desktop/code.desktop $APP_DIR
cp $LOCAL_DIR/usr/share/pixmaps/com.visualstudio.code.png $LOCAL_DIR/share/icons/com.visualstudio.code.png
cd $HOME

### skype
curl https://repo.skype.com/latest/skypeforlinux-64.deb -o $PROGRAM_DIR/skypeforlinux-64.deb
dpkg -x $PROGRAM_DIR/skypeforlinux-64.deb $LOCAL_DIR
cp $DIRECTORY/utils/desktop/code.desktop $APP_DIR
cp $LOCAL_DIR/usr/share/pixmaps/com.visualstudio.code.png $LOCAL_DIR/share/icons/com.visualstudio.code.png
ln -s $LOCAL_DIR/usr/share/skypeforlinux/skypeforlinux $LOCAL_DIR/bin/skypeforlinux
cp $DIRECTORY/utils/desktop/skypeforlinux.desktop $APP_DIR
cp $LOCAL_DIR/usr/share/pixmaps/skypeforlinux.png $LOCAL_DIR/share/icons/skypeforlinux.png
cd $HOME

### sublime-text
curl https://download.sublimetext.com/sublime_text_3_build_3211_x64.tar.bz2 -o $PROGRAM_DIR/sublime_text_3_build_3211_x64.tar.bz2
tar xvjf $PROGRAM_DIR/sublime_text_3_build_3211_x64.tar.bz2 -C $OPT_DIR
ln -s $OPT_DIR/sublime_text_3/sublime_text $LOCAL_DIR/bin/sublime_text
cp $DIRECTORY/utils/desktop/sublime_text.desktop $APP_DIR
cp $OPT_DIR/sublime_text_3/Icon/256x256/sublime-text.png $LOCAL_DIR/share/icons/sublime-text.png
cd $HOME

### telegram
curl https://updates.tdesktop.com/tlinux/tsetup.1.8.15.tar.xz -o $PROGRAM_DIR/tsetup.1.8.15.tar.xz
tar xf $PROGRAM_DIR/tsetup.1.8.15.tar.xz
#Run tsetup.1.8.15/Telegram/Telegram, then "Add to Favorites"

### slack
curl https://downloads.slack-edge.com/linux_releases/slack-desktop-4.1.2-amd64.deb -o $PROGRAM_DIR/slack-desktop-4.1.2-amd64.deb
dpkg -x $PROGRAM_DIR/slack-desktop-4.1.2-amd64.deb $LOCAL_DIR
ln -s $LOCAL_DIR/usr/bin/slack $LOCAL_DIR/bin/slack
cp $DIRECTORY/utils/desktop/slack.desktop $APP_DIR
cp $LOCAL_DIR/usr/share/pixmaps/slack.png $LOCAL_DIR/share/icons/slack.png
cd $HOME

### Intellij
curl https://download-cf.jetbrains.com/idea/ideaIC-2019.2.4.tar.gz -o $PROGRAM_DIR/ideaIC-2019.2.4.tar.gz
cd $PROGRAM_DIR
tar xf ideaIC-2019.2.4.tar.gz
cd idea-IC*
bash bin/idea.sh
cd $HOME

### ibus-teni
#####https://github.com/teni-ime/ibus-teni
