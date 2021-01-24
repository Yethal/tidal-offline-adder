#!/bin/sh
#increase this value if you keep hitting duplicates
swipe=2500

launchTidal(){
    adb shell monkey -p com.aspiro.tidal -c android.intent.category.LAUNCHER 1
}
getCords(){
    adb exec-out uiautomator dump /dev/tty | awk '{gsub("UI hierchary dumped to: /dev/tty", "");print}'|xmllint -xpath "//node$1/@bounds" - | awk -F "]" '{gsub("bounds=","");gsub(""\[","");gsub(","," ");print $1}'
}
pressButton(){
    xargs -r -I{} adb shell input tap {}
}
export -f pressButton

openMyCollection(){
    getCords "[@text="My Collection"]/preceding-sibling::node"|pressButton
}
export -f openMyCollection

openAlbums(){
    getCords "[@text="Albums"]/preceding-sibling::node"|pressButton
}
export -f getCords

getOptions(){
    getCords "[@resource-id="com.aspiro.tidal:id/options"]"
}
export -f getOptions

getAlbumNames(){
    adb exec-out uiautomator dump /dev/tty | awk '{gsub("UI hierchary dumped to: /dev/tty", "");print}'|xmllint -xpath "//node[@resource-id="com.aspiro.tidal:id/title"]/@text" -
}
export -f getAlbumNames

downloadAlbum() {
    adb shell input tap "$1" "$2"
    getCords "[@text="Download"]"|pressButton
}
export -f downloadAlbum

scrollAlbums(){
scrollTo="$(getCords [@text="Albums"])"
scrollFrom="$(getOptions|tail -n1)"
adb shell input swipe "$scrollFrom" "$scrollTo" "$swipe"
}
export -f scrollAlbums

#app launch
launchTidal
openMyCollection
openAlbums
while true; do
getOptions|xargs -I {} bash -c  'downloadAlbum {}'
scrollAlbums
done

#this loop is for debug purposes
#for i in {1..20}
#do
   #getAlbumNames
   #scrollAlbums
#done
