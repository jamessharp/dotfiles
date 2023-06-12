#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start deving on a project
# @raycast.mode silent
# @raycast.packageName James Dev
#
# Optional parameters:
# @raycast.icon 🖥
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "project name", "optional": false }
#
# Documentation:
# @raycast.description Opens up a project ready for development 
# @raycast.author James Sharp
# @raycast.authorURL https://github.com/jamessharp

PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
if [ -S ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ]
then 
  export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
fi

directory=$1
foundDirectory=''
if [ -z "$directory" ]; then
  echo "Empty directory is not allowed"
  exit 1
fi

set +e
directories=$(find "$HOME/Development" -name "$directory" -type d -maxdepth 2)
for dir in $directories; do
  if [[ -n "$(find "$dir" -name .vscode -maxdepth 1)" || -n "$(find "$dir" -name .git -maxdepth 1)" ]]; then
    foundDirectory=$dir
  fi
done

if [ -n "$foundDirectory" ]; then
  if [ -d "$foundDirectory/.devcontainer" ]; then
    echo "Opening $foundDirectory in devcontainer"
    # Check if Docker is already running
    if ! docker info > /dev/null 2>&1; then
      echo "Starting docker and waiting for it to be ready..."
      # Open Docker Desktop
      open --background -a Docker

      # Wait for Docker to start
      while ! docker info > /dev/null 2>&1;
      do
        sleep 1
      done

      echo "Docker is now up and running!"
    fi

    devcontainer open "$foundDirectory"
  elif [ -n "$(which code)" ]; then
    echo "Opening $foundDirectory"
    code -n "$foundDirectory"
  else
    echo "Opening $foundDirectory in devcontainer"
    open -n -b "com.microsoft.VSCode" --args "$foundDirectory"
  fi

  osascript ./dev-windows.applescript
else
  echo "No such directory in '$HOME/Development' with name $1"
fi
exit 0