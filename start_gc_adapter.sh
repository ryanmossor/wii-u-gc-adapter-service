#!/bin/sh

MODULE="uinput"

# Enable the module if it isn't already
if ! lsmod | grep -wq "^${MODULE}"; then
	echo "Module $MODULE not enabled yet... enabling"
	modprobe uinput
	echo "Module $MODULE enabled!"
fi

echo "Starting wii-u-gc-adapter..."
/usr/local/bin/wii-u-gc-adapter --raw &
echo "Started wii-u-gc-adapter!"
exit 0
