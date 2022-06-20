on run argv
  set launchedSafari to false
  if application "Safari" is running then
    set safariWindowCount to 0
    tell application "System Events"
      if visible of process "Safari" is true then
        tell process "Safari" to set safariWindowCount to count of windows
      end if
    end tell

    if safariWindowCount is 0 then
      tell application "Safari" to make new document
      set launchedSafari to true
    end if
  else
    tell application "Safari" to activate
    set launchedSafari to true
  end if
  
  -- Resize the windows...
  tell application "Finder"
    get bounds of window of desktop
	end tell

	tell application "Finder"
    set desktopBounds to bounds of window of desktop
    set screenWidth to item 3 of desktopBounds
    set screenHeight to item 4 of desktopBounds
	end tell

  if launchedSafari is true
      tell application "System Events" to tell application process "Safari"
      try
        set size of window 1 to {screenWidth / 2.0, screenHeight}
        set position of window 1 to {0, 0}
      on error errmess
        log errmess
        -- no window open
      end try
    end tell
  end if 

  tell application "System Events" to tell application process "Code"
		try
			set position of window 1 to {screenWidth / 2.0, 0}
      set size of window 1 to {screenWidth / 2.0, screenHeight}
		on error errmess
			log errmess
			-- no window open
		end try
	end tell
end run