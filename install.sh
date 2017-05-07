# Mount boot partition
echo "Mounting boot partition..."
mount /dev/mmcblk0p1 /boot

# Recompile kernel in order to prevent the following error:
# modprobe: ERROR: could not insert '8812au': Exec format error 
# In the default kali 2017.1 ARM RPI2/3 image, the kernel source is located in /usr/src/kernel/
echo "Recompiling the kernel... WARNING: This will take some time!"
cd /usr/src/kernel
make -j $(grep -c processor /proc/cpuinfo)

echo "Installing modules..."
make modules_install

echo "Copying new kernel to boot partition..."
perl scripts/mkknlimg --dtok arch/arm/boot/zImage /boot/kernel7.img
cp arch/arm/boot/dts/*.dtb /boot/
cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/

# Compile the rtl8812au drivers
echo "Compiling and installing the rtl8812au drivers..."
git clone -b v4.3.21 https://github.com/astsam/rtl8812au.git /usr/src/local
cd /usr/src/local
make -j $(grep -c processor /proc/cpuinfo) CROSS_COMPILE=arm-linux-gnueabihf- ARCH=arm
make install

# Enable the drivers
modprobe 8812au

echo "Done! Please reboot your system now."
