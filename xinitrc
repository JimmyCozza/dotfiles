#!/bin/sh

# Start GNOME Keyring
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# Start AwesomeWM
exec /usr/local/bin/awesome