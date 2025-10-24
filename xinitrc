#!/bin/sh

# Start GNOME Keyring
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

# Start polkit agent for authentication dialogs
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start AwesomeWM
# NOTE: Build and install from ~/awesome-from-scratch before first use
exec /usr/local/bin/awesome