# tidal-offline-adder
Script to automate the tedious process of adding your entire Tidal collection to offline storage

# Usage:
* Make sure the phone is connected to the internet
* Make sure adb server is started and the phone detected (`adb devices` returns a device id)
* Connect your phone to your PC via adb
* Launch the script
* Kill the script manually once it gets to the end of the list (I did not implement detecting whether we're at the end of the list yet)

# Debugging
If the loop doesn't scroll through the list properly comment out the main loop, increase the swipe value
