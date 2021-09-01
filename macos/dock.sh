#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Siri.app"
dockutil --no-restart --add "/Applications/Launchpad.app"
dockutil --no-restart --add "/Applications/App Store.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Mail.app"
dockutil --no-restart --add "/Applications/Messages.app"
dockutil --no-restart --add "/Applications/FaceTime.app"
dockutil --no-restart --add "/Applications/Contacts.app"
dockutil --no-restart --add "/Applications/Photos.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/System Preferences.app"

killall Dock
