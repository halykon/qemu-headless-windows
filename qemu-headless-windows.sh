#!/bin/sh
#Get VirtIO drivers from https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/
#Generate own MAC Address!

WINIMG=/path/to/win10.iso
VIRTIMG=/path/to/virtio-drivers.iso
VMLOC=/path/to/vm/location
qemu-system-x86_64 \
-enable-kvm \
-daemonize \
-m 8G \
-machine q35,accel=kvm \
-smp cores=2,threads=4 \
-cpu host \
-smbios type=2 \
-vga qxl \
-drive driver=raw,file=${VMLOC}/win10.img,if=virtio \
-cdrom ${WINIMG} \
-drive file=${VIRTIMG},index=3,media=cdrom \
-rtc base=localtime,clock=host \
-usb -device usb-kbd -device usb-tablet \
-device e1000-82545em,netdev=net0,mac=12:34:56:78:90 \
-netdev user,id=net0
-nographic \
-vnc :0 \
-k en-us
# add -net user,smb=$HOME if you want a shared drive
# add hostfwd=protocoll::hostport-:guestport to line 23 for port forwarding to VM 