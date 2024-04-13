# Installer by: VGFreak95

# NEEDS SUDO PERMISSIONS TO EXECUTE

# Required packages:
# make (to build the adapter binary)
# libudev
# libusb(x) >= 1.0.16

if ! command -v make &>/dev/null; then
	echo "Error: make command not found. Please install the necessary packages."
	exit 1
fi

# Build the original wii-u-gc-adapter
make

# Make it executable for everyone
chmod a+x wii-u-gc-adapter

# Move scripts in proper areas
mkdir /usr/local/bin/wii-u-gc-adapter.d
cp start_gc_adapter.sh stop_gc_adapter.sh /usr/local/bin/wii-u-gc-adapter.d/
cp wii-u-gc-adapter /usr/local/bin/
cp wii-u-gc-adapter.service /etc/systemd/system/

# New .service file added so systemd needs to reload
systemctl daemon-reload

# Enable the service
systemctl enable wii-u-gc-adapter.service

echo "Installation completed successfully."
echo "You can start the service using: systemctl start wii-u-gc-adapter.service"
