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

#functions
checkTidal(){
    adb shell pm list packages|grep com.aspiro.tidal >/dev/null || echo "Tidal app not installed" && exit 1
}

checkDep(){
    local dep=$1
    type $dep || echo "$dep not found please install it and run the script again" && exit 1
}

checkDevice(){
    adb devices|grep device$ >/dev/null || echo "No device found please run adb devices and see if your devices is detected" && exit 1
}

launchTidal(){
    adb shell monkey -p com.aspiro.tidal -c android.intent.category.LAUNCHER 1
}
export -f launchTidal

getLayout(){
    adb exec-out uiautomator dump /dev/tty | awk '{gsub("UI hierchary dumped to: /dev/tty", "");print}'
}
export -f getLayout

getCords(){
    getLayout|xmllint --xpath "$1/@bounds" - | tr '' '\n' | awk '{gsub("[^0-9.-]"," "); print $1,$2}'
}
export -f getCords

pressButton(){
    adb shell input tap $1 $2
}
export -f pressButton

openMyCollection(){
    pressButton $(getCords "$mycollection")
}
export -f openMyCollection

openAlbums(){
    pressButton $(getCords "$albums")
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
    pressButton $1 $2
    sleep 1
    pressButton $(getCords "$downloadButton")
}
export -f downloadAlbum

scrollAlbums(){
    scrollTo="$(getCords $albumBanner)"
    scrollFrom="$(getOptions|tail -n1)"
    adb shell input swipe "$scrollFrom" "$scrollTo" "$swipe"
}
export -f scrollAlbums
