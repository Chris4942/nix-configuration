#!/bin/sh
set -eo pipefail

DEVICE='0003:05AC:027C.0005'
if (ls /sys/bus/hid/drivers/magicmouse/ | rg -q $DEVICE); then
        sudo echo $DEVICE > /sys/bus/hid/drivers/magicmouse/unbind
else
        sudo echo $DEVICE > /sys/bus/hid/drivers/magicmouse/bind
fi
