#!/bin/sh

MODULE="uinput"

# Find the PID of the wii-u-gc-adapter process
PID=$(ps -e | grep "wii-u-gc-adapt" | awk '{print $1}')
if [ -n "$PID" ]; then
	# Kill the process
	echo "Stopping wii-u-gc-adapter process with PID: $PID"
	kill "$PID"

	# Wait a moment for the process to exit
	sleep 2

	# Check if the process is still running and force kill if necessary
	if ps -p "$PID" >/dev/null; then
		echo "Process with PID $PID still running, killing forcefully"
		kill -9 "$PID"
		if [ $? -eq 0 ]; then
			echo "wii-u-gc-adapter process killed forcefully"
		else
			echo "Failed to kill wii-u-gc-adapter process"
		fi
	else
		echo "wii-u-gc-adapter process stopped"
	fi
else
	echo "wii-u-gc-adapter process not found"
fi

# Remove the module if it was enabled
if lsmod | grep -wq "^${MODULE}"; then
	echo "Module $MODULE was enabled... disabling"
	rmmod "$MODULE" -f
else
	echo "Module $MODULE was not enabled"
fi

exit 0
