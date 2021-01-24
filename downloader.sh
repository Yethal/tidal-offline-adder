#!/bin/sh
#increase this value if you keep hitting duplicates
swipe=2500

#selectors
mycollection="//node[@text=\"My Collection\"]/preceding-sibling::node"
albums="//node[@text='Albums']/preceding-sibling::node"
options="//node[@resource-id=\"com.aspiro.tidal:id/options\"]"
albumnames="//node[@resource-id='com.aspiro.tidal:id/title']/@text"
downloadButton="//node[@text='Download']"
albumBanner="//node[@text=\"Albums\"]"

launchTidal(){
    adb shell monkey -p com.aspiro.tidal -c android.intent.category.LAUNCHER 1
}
export -f launchTidal

getLayout(){
    adb exec-out uiautomator dump /dev/tty | awk '{gsub("UI hierchary dumped to: /dev/tty", "");print}'
}
export -f getLayout

getCords(){
    getLayout|xmllint --xpath "$1/@bounds" - | awk '{gsub("[^0-9.-]"," "); print $1,$2}'
}
export -f getCords

pressButton(){
    xargs -r -I{} adb shell input tap {}
}
export -f pressButton

openMyCollection(){
    getCords "$mycollection"|pressButton
}
export -f openMyCollection

openAlbums(){
    getCords "$albums"|pressButton
}
export -f getCords

getOptions(){
    getCords "$options"
}
export -f getOptions

getAlbumNames(){
    getLayout|xmllint --xpath "$albumnames" -|cut -f2 -d '"'
}
export -f getAlbumNames

downloadAlbum() {
    pressButton
    getCords "$downloadButton"|pressButton
}
export -f downloadAlbum

scrollAlbums(){
    scrollTo="$(getCords $albumBanner)"
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
#   getAlbumNames
#   echo "========"
#   scrollAlbums
#done
