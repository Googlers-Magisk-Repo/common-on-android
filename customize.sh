#!/system/bin/sh

print() {
    printf $@
}

chmodBin() {
    chmod +x $MODPATH/system/bin/$@
}

systemWrite() {
    if [ $1 = true ]; then
        mount -o rw,remount /
        print "System is now read/write"
        elif [ $1 = false ]; then
        mount -o ro,remount /
        print "System is now read-only"
    else
        print "System not writeable"
    fi
}

if [ ! "$ANSI_SUPPORT" == "true" ] || [ ! -n "$MMM_EXT_SUPPORT" ]; then
    abort "! This module need to be executed in Fox's Magisk Module Manager with ANSI support"
    exit 1
fi

for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo
systemWrite true

arr=( "transfer" "zip" "bash" "wget" "aapt" "python" "node" "yarn" "systemWrite" ""  )

for item in "${arr[@]}"
do
    ui_print "\e[38;5;82mMaking \e[34m${item} \e[38;5;198mExecuteable"
    chmodBin $item
done

systemWrite false
for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo