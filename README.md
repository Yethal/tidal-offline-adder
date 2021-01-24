# tidal-offline-adder
Script to automate the tedious process of adding your entire Tidal collection to offline storage

# Usage:
* Make sure the phone is connected to the internet
* Make sure adb server is started and the phone detected (`adb devices` returns a device id)
* Connect your phone to your PC via adb
* Launch the script
* Kill the script manually once it gets to the end of the list (I did not implement detecting whether we're at the end of the list yet)

# Debugging
If the loop doesn't scroll through the list properly comment out the main loop, uncomment out the debug one, run it and keep increasing the swipe value until the album list printed to terminal matches what you're seeing in the app

# todo
Rewrite this to Python so it works on other platforms
Add more functionality (Download by artist, omit specific albums etc)
Maybe add some help function, and use script argument to determine what to do
