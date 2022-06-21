#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Note
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/notes.png
# @raycast.argument1 { "type": "text", "placeholder": "Note Title" }
# @raycast.packageName Notes

# Documentation:
# @raycast.description Open Note via its Title
# @raycast.author Vardan Sawhney
# @raycast.authorURL https://github.com/commai

on run argv
  set noteTitle to item 1 of argv
	tell application "Notes"
		if exists note (noteTitle)
			show note (noteTitle)
		else
      log "Sorry, the note \"" & (noteTitle) & "\" was not found" 
      tell application "Notes"
        activate
        make new note with properties {name: noteTitle, body: ""}
        show note (noteTitle)
      end tell
		end if
	end tell
end run