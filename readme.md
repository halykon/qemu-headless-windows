# Qemu Windows Startscript

## Prerequisites
You'll need the following things to get this script running
* A Windows 10 ISO (use the Media Creation Tool provided by Microsoft)
* A Windows 10 License
* VirtIO Drivers (get them [here](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/))
* VNC viewer software on your local machine

## Setup
1. Install Qemu

   * Ubuntu/Debian: `sudo apt install qemu-system qemu-utils`
   * Arch/Manjaro: `sudo pacman -S qemu`
   * Void Linux: `sudo xbps-install -Su qemu`
   * OpenSUSE Tumbleweed: `sudo zypper in qemu-tools qemu-kvm qemu-x86`
   * Fedora: `sudo dnf install qemu qemu-img`

2. Clone the script to your machine 

   ```git clone https://github.com/thesicstar/qemu-headless-windows.git```

3. Create a harddrive using 
   
   `qemu-img create -f raw win10.img 60G`

   Change the size (60G in this case) to the size you want your harddrive to be.

4. Edit `qemu-headless-windows.sh` to fit your needs
   * Set the correct paths to your Windows Image, VirtIO Image and VM Location
   * Assign memory and cpu cores as you like (option -m and -cpu)
   * Make sure line 16 correctly points to your created harddrive
   * Generate a unique MAC-Address using any online tool or using `openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//'`

5. Make the script executable

   ```chmod +x qemu-headless-windows.sh```

6. Start the script

   ```./qemu-headless-windows.sh```

## Connecting to the VM
Your VM now runs and you can connect to it using any VNC viewer software. Just connect to localhost:5900 and watch your windows boot up.

If you are on a remote machine, use SSH to tunnel port 5900 to your machine and connect to localhost aswell

```ssh -L 5900:your-ip-address:5900 your-username@your-ip-address```

# FAQ

## Q: Can i have a shared drive between Linux and the Windows VM?
A: Yes, just append `-net user,smb=/path/to/shared/folder` to the script. Don't forget to add a `\` if you don't add it to the end of the script.

## Q: I want to forward some ports from my Linux machine to my VM. Is that possible?
A: Yes, add `,hostfwd=protocoll::hostport-:guestport` to line 21 (`-netdev user,id=net0`) of the script. 

For example: `-netdev user,id=net0,hostfwd=tcp::5555-:22` will forward your server's port 5555 to your VM's port 22, enabling you to ssh to your VM via your server's IP and port 5555. (Provided you have a running SSH Server on your VM)

## Q: Does this work with a Linux guest aswell?
A: Though i haven't tried it yet, there should be little to no problems using this script to set up a Linux guest.

## Q: Does this work with a macOS guest?
A: No. If you want to virtualize macOS, i highly recommend you to check out [foxlet's macOS-Simple-KVM](https://github.com/foxlet/macOS-Simple-KVM)