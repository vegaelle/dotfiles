export $(dbus-launch)
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG AGENT INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

xrdb -merge ~/.Xresources

~/bin/export_x_info.sh

exec xscreensaver -no-splash &
setxkbmap fr bepo -option compose:prsc
exec /usr/bin/awesome
