#!/bin/sh
set -eo pipefail

TRACKPAD_CACHE='/tmp/trackpad'

if [ ! -f $TRACKPAD_CACHE ]; then
        ls /sys/bus/hid/drivers/magicmouse/ | rg '0003:05AC:027C.000\d' | tr -d \\n > $TRACKPAD_CACHE
fi

DEVICE=`cat $TRACKPAD_CACHE`

if (ls /sys/bus/hid/drivers/magicmouse/ | rg -q $DEVICE); then
        sudo echo $DEVICE > /sys/bus/hid/drivers/magicmouse/unbind
else
        sudo echo $DEVICE > /sys/bus/hid/drivers/magicmouse/bind
fi
