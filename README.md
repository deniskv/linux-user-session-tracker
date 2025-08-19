# linux-user-session-tracker
Track user session on ubuntu-server machines


### Setup instructions

1. Upload ••session-tracker.sh•• to `usr/local/bin/send-slack-alert.sh`
2. Add to the end of `/etc/profile`
  `
  if [ -n "$SSH_CONNECTION" ]; then
    sleep 1
    /usr/local/bin/send-slack-alert.sh ":inbox_tray: User *${USER}* logge in  *${HOSTNAME}:${SERVER_IP}* (with ${SSH_CLIENT%% *})"
  fi
  `
3. Append to the beginning of the file `/etc/bash.bashrc` 
  `
    function track_logout() {
    if [ -n "$SSH_CONNECTION" ] && [ -z "$BASH_SUBSHELL" ]; then
        /usr/local/bin/send-slack-alert.sh ":outbox_tray: User *${USER}* logged out *${HOSTNAME}:${SERVER_IP}*"
    fi
    }

    trap track_logout EXIT
  `
4. Add also 
  `
    alias sudo='sudo alert-sudo '
    function alert-sudo() {
    /usr/local/bin/send-slack-alert.sh ":exclamation: User *${USER}* ran as sudo *${HOSTNAME}:${SERVER_IP}* (script: $*)"
    
      command sudo "$@"
    }
  `

  