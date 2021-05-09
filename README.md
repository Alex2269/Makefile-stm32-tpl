# Makefile stm32 cc/cpp template

``` cpp

STM32CubeMX:
notes:

#  apt-get purge openjdk-*
#  apt install openjdk-14-jdk
#  apt install openjdk-14-jre
$  update-java-alternatives --list
#  update-alternatives --config java


# open access to usb devices, st-link, etc:
apt install libudev-dev libusb-1* gcc-arm-none-eabi gdb-arm-none-eabi

to allow access user 'urername' to usb to devices:

useradd -g dialout 'username'
addgroup --system 'username' dialout
addgroup --system 'username' root
addgroup --system 'username' plugdev
groups 'username'

```

