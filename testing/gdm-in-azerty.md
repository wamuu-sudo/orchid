Bug du clavier qwerty dans gdm avec orchid linux

orchid utilise elogind + OpenRC (+ openrc-settingsd) + Wayland avec un user "gdm" qui est actif lmors de l'affichage de gdm.

# Method using openrc-settingsd

as root: 
```
mv /etc/X11/xorg.conf.d/10-keyboard.conf /etc/X11/xorg.conf.d/30-keyboard.conf
```

~~we define the locale here: KEYMAP=${KEYMAP:-fr} , fr=french layout, us=us layout etc.~~

~~as root:~~

~~source /etc/conf.d/keymaps &&
KEYMAP=${KEYMAP:-fr}          &&
gdbus call --system                                             \
           --dest org.freedesktop.locale1                       \
           --object-path /org/freedesktop/locale1               \
           --method org.freedesktop.locale1.SetVConsoleKeyboard \
           "$KEYMAP" "$KEYMAP_CORRECTIONS" true true~~


Now, gdm is using fr layout.


##################
# This method below using blocaled is broken on Orchid as we have openrc-settingsd and it conflict with blocaled, thus the FIXME: cp... below
##################

Upstream :
https://github.com/lfs-book/blocaled
version 0.4

# Installation de blocaled

Documentation de blocaled :
https://linuxfromscratch.org/blfs/view/stable/general/blocaled.html
version 0.4 testée avec Gnome 41
```
wget -c https://github.com/lfs-book/blocaled/releases/download/v0.4/
tar xvpf blocaled-0.4.tar.xz
cd blocaled-0.4
./configure --prefix=/usr --sysconfdir=/etc --with-localeconfig=/etc/env.d/02locale --with-keyboardconfig=/etc/conf.d/keymaps --with-xkbdconfig=/etc/X11/xorg.conf.d/10-keyboard.conf &&
make
```
Now, as the root user:
```
make install
````
## Configuration de blocaled

as root :
```
cat > /etc/profile.d/i18n.sh << "EOF"
# Begin /etc/profile.d/i18n.sh

if [ -r /etc/env.d/02locale ]; then source /etc/env.d/02locale; fi

if [ -n "$LANG" ];              then export LANG; fi
if [ -n "$LC_TYPE" ];           then export LC_TYPE; fi
if [ -n "$LC_NUMERIC" ];        then export LC_NUMERIC; fi
if [ -n "$LC_TIME" ];           then export LC_TIME; fi
if [ -n "$LC_COLLATE" ];        then export LC_COLLATE; fi
if [ -n "$LC_MONETARY" ];       then export LC_MONETARY; fi
if [ -n "$LC_MESSAGES" ];       then export LC_MESSAGES; fi
if [ -n "$LC_PAPER" ];          then export LC_PAPER; fi
if [ -n "$LC_NAME" ];           then export LC_NAME; fi
if [ -n "$LC_ADDRESS" ];        then export LC_ADDRESS; fi
if [ -n "$LC_TELEPHONE" ];      then export LC_TELEPHONE; fi
if [ -n "$LC_MEASUREMENT" ];    then export LC_MEASUREMENT; fi
if [ -n "$LC_IDENTIFICATION" ]; then export LC_IDENTIFICATION; fi

# End /etc/profile.d/i18n.sh
EOF
```

as root:
```
cat > /etc/locale.conf << EOF
# Begin /etc/locale.conf

LANG=$LANG

# End /etc/locale.conf
EOF
```

FIXME: bug : The reason is openrc-gsettingsd taking over blocaled. The deamon (openrc-gsettingsd) search for /etc/X11/xorg.conf.d/30-keyboard.conf , but we made clear at configure time (blocaled) it should use /etc/X11/xorg.conf.d/10-keyboard.conf

as root: 
```
cp /etc/X11/xorg.conf.d/10-keyboard.conf /etc/X11/xorg.conf.d/30-keyboard.conf
```

we define the locale here: KEYMAP=${KEYMAP:-fr} , fr=french layout, us=us layout etc.

as root:
```
source /etc/conf.d/keymaps &&
KEYMAP=${KEYMAP:-fr}          &&

gdbus call --system                                             \
           --dest org.freedesktop.locale1                       \
           --object-path /org/freedesktop/locale1               \
           --method org.freedesktop.locale1.SetVConsoleKeyboard \
           "$KEYMAP" "$KEYMAP_CORRECTIONS" true true
```

INSTALLATION COMPLETED, you should now ba able to use gdm with french keyboard

######################################

Set GNOME in french for some $USER:

as root
```
su -c "gsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'fr')]\"" $USER
```

######################################

To change wallpapers on GNOME:

Modify this file

```
/usr/share/gnome-background-properties/gnome-backgrounds.xml
```
