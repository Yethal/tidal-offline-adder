#!/bin/sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/functions.sh"
IFS='
'
#sanity checks
checkDep adb
checkDep xmllint
checkDevice
checkTidal

#app launch
 launchTidal
 openMyCollection
 openAlbums
 while true; do
     for x in `getOptions`; do downloadAlbum $x; done
     scrollAlbums
 done
