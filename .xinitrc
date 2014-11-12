export $(dbus-launch)
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG AGENT INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

xrdb -merge ~/.Xresources

exec xscreensaver -no-splash &
setxkbmap fr bepo -option compose:pscr
exec /usr/bin/awesome
