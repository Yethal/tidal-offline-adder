# tidal-offline-adder
Script to automate the tedious process of adding your entire Tidal collection to offline storage

# Usage:
* Make sure the phone is connected to the internet
* Make sure adb server is started and the phone detected (`adb devices` returns a device id)
* Connect your phone to your PC via adb
* Launch the script
* Kill the script manually once it gets to the end of the list (I did not implement detecting whether we're at the end of the list yet)

# Debugging
If the loop doesn't scroll through the list properly navigate to the Albums list in the app, run `source functions.sh`, `getAlbumNames`, `scrollAlbums` and `getAlbumNames` again to see if the list printed in the terminal matches what's being displayed in the Tidal app

# todo
* Rewrite this to Python so it works on other platforms
* Add more functionality (Download by artist, omit specific albums etc)
* Maybe add some help function, and use script argument to determine what to do
