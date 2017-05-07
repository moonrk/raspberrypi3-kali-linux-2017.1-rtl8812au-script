# Raspberry PI 3 Kali Linux 2017.1 rtl8812au install script

The rtl8812au drivers from https://github.com/astsam/rtl8812au.git v4.3.21 compile fine in Kali Linux 2017.1 on the Raspberry PI 3, but fail to load due to the following error:

`modprobe: ERROR: could not insert '8812au': Exec format error`

This is most likely caused by the crosscompiling of the stock Kali Linux image for the ARM processor. In order to build the driver on the Raspberry PI itself, we need to recompile the kernel and its modules on the Raspberry PI to get rid of the error.

This script automates the process. To launch, simply run:

```
git clone https://github.com/moonrk/raspberrypi3-kali-linux-2017.1-rtl8812au-script.git
cd raspberrypi3-kali-linux-2017.1-rtl8812au-script
./install.sh
```

Make sure to perform the adequate backups of your system before attempting to run this script.
