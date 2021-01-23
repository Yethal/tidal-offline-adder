# tidal-offline-adder
Script to automate the tedious process of adding your entire Tidal collection to offline storage

# Usage:
* Make sure the phone is connected to the internet
* Connect your phone to your PC via adb
* Launch the script
* Kill the script manually once it gets to the end of the list (I did not implement detecting whether we're at the end of the list)

# Debugging
If the loop doesn't scroll through the list properly comment out the main loop, uncomment the debug one, run it and see if the album names printed to stdout are duplicated. If they are increase the last argument to adb shell input swipe in scrollAlbums() function from 2500 to a higher value
