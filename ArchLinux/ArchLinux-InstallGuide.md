# ArchLinux Install Guide

*based on archlinux-2024.07.01-x86_64 in Orcle VM VirtualBox*

*Written on 19 Sep*

### check the disk, partition, and mount

using `lsblk -l`/`lsblk -f`/`fdisk -l` to list the disk info:

`lsblk -l`

<img src="./img/1-1-3.png" alt="1-3" style="zoom:75%;" />

`lsblk -f`

![1-1](./img/1-1-1.png)

`fdisk -l`

<img src="./img/1-1-2.png" alt="1-1-2" style="zoom:75%;" />

then, cfdisk /dev/xxx to enter *xxx* disk to partition it

<img src="./img/1-2.png" alt="1-2" style="zoom:75%;" />

It will appear

<img src="./img/1-3.png" alt="1-3" style="zoom:40%;" />

Here, we use GPT partition type (a new partition type other than MBR/DOS). It's quite commonly used, especially for huge volume disk and UEFI.

**Notice**: If this is for dual system, DO NOT create new EFI sector or format the disk. Skip this step and directly mount the sectors/partitions.

<img src="./img/1-4.png" alt="1-4" style="zoom:40%;" />

After entering, we will create some partitions in this interface, using *up*, *down*, *left*, *right* keys for moving and *enter* for selecting/confirming.

First, create an EFI parition.

`NEW` a 300-500M size partition

<img src="./img/1-4-2.png" alt="1-4-2" style="zoom:40%;" />

Using `Type` at the bottom to modify the size type to **EFI System**

<img src="./img/1-4-3.png" alt="1-4-3" style="zoom:40%;" />

<img src="./img/1-4-4.png" alt="1-4-4" style="zoom:40%;" />

[Optional] Create a  partition for swap

Still, `NEW` a partition of any size for swap, here we use 4G

<img src="./img/1-4-5.png" alt="1-4-5" style="zoom:40%;" />

<img src="./img/1-4-6.png" alt="1-4-6" style="zoom:40%;" />

Using `Type` to modify the size type to **Linux swap**

<img src="./img/1-4-7.png" alt="1-4-7" style="zoom:40%;" />

<img src="./img/1-4-8.png" alt="1-4-8" style="zoom:40%;" />

The rest space will go to root partition

<img src="./img/1-4-9.png" alt="1-4-9" style="zoom:40%;" />

<img src="./img/1-4-10.png" alt="1-4-10" style="zoom:40%;" />

Let the type be the default one, i.e. **Linux filesystem**

<img src="./img/1-4-11.png" alt="1-4-11" style="zoom:40%;" />

Take `Write` and enter `yes` to write. Then using `Quit` to get back to the command line

<img src="./img/1-4-12.png" alt="1-4-12" style="zoom:40%;" />

<img src="./img/1-4-13.png" alt="1-4-13" style="zoom:40%;" />

Now, we `fdisk -l` (or other commands) and can see the partitions have been written. Please make sure every partition is correctly named and typed with appropriate size

<img src="./img/1-4-14.png" alt="1-4-14" style="zoom:60%;" />

Now we will format the partitions

`mkfs.ext4 /dev/[root]` to format root. Here, it will be `mkfs.ext4 /dev/sda3`. Typing `y` to confirm if needed.

<img src="./img/1-5-1.png" alt="1-5" style="zoom:60%;" />

`mkswap /dev/[swap]` to format the swap partition. Skip this step if you didn't set the swap partition. Here, it will be `mkswap /dev/sda2`.

<img src="./img/1-5-2.png" alt="1-5-2" style="zoom:75%;" />

`mkfs.fat -F 32 /dev/[EFI]` to format the EFI partition. Here it will be `mkfs.fat -F 32 /dev/sda1`.

<img src="./img/1-5-3.png" alt="1-5-3" style="zoom:75%;" />

Reassure that everything is correct.

<img src="./img/1-5-4.png" alt="1-5-4" style="zoom:60%;" />

Now, we will mount the partition to directories.

`mount /dev/[root] /mnt` to mount the partition for root to `/mnt`. Here is `mount /dev/sda3 /mnt`

<img src="./img/1-6-1.png" alt="1-6" style="zoom:75%;" />

`mount --mkdir /dev/[EFI] /mnt/boot` to mount partition for EFI to `/mnt/boot`. Here is `mount --mkdir /dev/sda1 /mnt`

<img src="./img/1-6-2.png" alt="1-6-2" style="zoom:75%;" />

`swapon /dev/[swap]` to set the swap sector. Here is `swapon /dev/sda2`

<img src="./img/1-6-3.png" alt="1-6-3" style="zoom:75%;" />

### Install the basic system

`pacstrap -K /mnt base linux linux-firmware base-devel`

If not working, using `iwctl` to connect to the network first as `pacman` needs access to the network.

Here, `linux` is the kernel type. There are other editions to choose from:

-   `linux` for **Mainline**: Stable and commonly used
-   `linux-lts` for **LTS**: Long-term supported and most up-to-date; No predefined lifetime; Will have the same kernel version in a long time. The patches *normally* won't destroy anything. Can use this kernel with older edition for older firmwares to enjoy new softwares with stability.
-   `linux-hardened` for **Hardened**: This is a hardened version for the newest stable kernel. This is for security-related users and notably some packages may not work in this kernel.
-   `linux-zen` for **Performance Optimization**: Fully exploit the system. This edition can be for daily uses and the performance is opitimized in systems and games. The thourghput and power, however, is fully expoited.

<img src="./img/2-1.png" alt="2-1" style="zoom:40%;" />

<img src="./img/2-2.png" alt="2-2" style="zoom:40%;" />

It will install corresponding packages and systems.

`genfstab -U /mnt >> /mnt/etc/fstab` to load the current mounting info to a log in the system.

<img src="./img/2-3.png" alt="2-3" style="zoom:75%;" />

`arch-chroot /mnt` to enter the system.

<img src="./img/2-4.png" alt="2-4" style="zoom:75%;" />

### Configure the system

#### timezone

set the timezone. Using `ln -sf /usr/share/zoneinfo/[Continent]/[City] /etc/localtime` to link the localtime file to the corresponding timezone file. Here we are using Shanghai for example.

`ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`

Using `hwclock --systohc` to synchronise the time

<img src="./img/3-1.png" alt="3-1" style="zoom:70%;" />

#### editor

[optional] `pacman -Sy` to synchronise local package database with remote one

<img src="./img/3-2.png" alt="3-2" style="zoom:40%;" />

`pacman -S [editorname]` to install a command-line editor you'd like to use. Here is **vim**.

<img src="./img/3-3.png" alt="3-3" style="zoom:40%;" />

#### language

`cd /etc` and `[editor] locale.gen`. Here is `vim locale.gen`

Remove the pound `#` in front of `en_US.UTF-8` 

`Ctrl`+`o` to save and `Ctrl`+`x` to quit for nano, or `:wq` to write and quit for vim

<img src="./img/3-4-1.png" alt="3-4-1" style="zoom:50%;" />

<img src="./img/3-4-2.png" alt="3-4-2" style="zoom:40%;" />

*Note: for other languages, find the corresponding coding and un-comment the line*

`locale-gen` to load the language config

<img src="./img/3-4-3.png" alt="3-4-3" style="zoom:75%;" />

`touch locale.conf` or use the editor to automatically generate the file. (Note: this is still under `/etc` directory)

`[editor] locale.conf` to edit

<img src="./img/3-5-1.png" alt="3-5-1" style="zoom:75%;" />

enter `LANG=en_US.UTF-8`, write and save.

<img src="./img/3-5-2.png" alt="3-5-2" style="zoom:40%;" />

#### user and password

`passwd` to set the password for root. Note: password will be invisible in command line and need to type twice

<img src="./img/3-6.png" alt="3-6" style="zoom:75%;" />

`useradd -m [username]` to add a new user. Here, for example, using `useradd -m arch`. Note: `-m` will meanwhile create the home directory under `/home` as `/home/[username]`

`passwd [username]` to set the username. Here is `passwd arch`

To delete the user, using `userdel [option] [username]`. For `[option]`, the most commonly used are `-f` to force delete and `-r` to delete the home directory and mail spool (`/var/spool/mail/[username]`).

Related files: 

-   `/etc/group` for user-group info
-   `/etc/login.defs` for *shadow* password plugin config info
-   `/etc/passwd` for user info (not password info, only the hash values of passwords are saved for verifications, no password plaintexts saved in any files)
-   `/etc/shadow` for user account security info, including hash values of passwords, user expiry date,etc. Only readable by root
-   `/etc/subgid` for user subordinate group IDs
-   `/etc/subid` for user subordinate user IDs

<img src="./img/3-7.png" alt="3-7" style="zoom:75%;" />

to set up the `sudo` permission, still under `/etc`, `[editor] sudoers`

find the line `root ALL=(ALL:ALL) ALL`, and append a new line after it

`[username] ALL=(ALL) ALL`

Here is `arch ALL=(ALL) ALL`

<img src="./img/3-8-1.png" alt="3-8-1" style="zoom:40%;" />

<img src="./img/3-8-2.png" alt="3-8-2" style="zoom:40%;" />

*Note: as this file is readonly, in vim, need to type `:w!` to force write first, then `:q` to quit*

Edit/Create `/etc/hostname`. Every time when booting, the system will read this file to identify the users for this system and list them in the network (when ssh or other purposes). This is for convenience as the users can just use readable strings rather than IDs.

So just append `[username]` in a new line in the file. Here is simply  `arch`

<img src="./img/3-9-1.png" alt="3-9-1" style="zoom:75%;" />

<img src="./img/3-9-2.png" alt="3-9-2" style="zoom:40%;" />

#### booting config

`pacman -Sy` to synchronize

then, `pacman -S grub efibootmgr`

They are both types of 

`grub` is *Grand Unified Boot Loader*, which is a program for loading and managing system booting

`efibootmgr` is for EFI management and adjustment

Notably, if this is in a dual system, you need to mount partitions in the other system for reading access. This needs `os-prober`: `pacman -S grub efibootmgr os-prober`

<img src="./img/3-11.png" alt="3-11" style="zoom:40%;" />

*(The example has later installed `os-prober`)*

For os-prober, navigate back to root directory `cd /`. Uncomment the last line in `/etc/default/grub`, i.e. `GRUB_DISABLE_OS_PROBER=false`

<img src="./img/3-12-1.png" alt="3-12-1" style="zoom:70%;" />

<img src="./img/3-12-2.png" alt="3-12-2" style="zoom:65%;" />

`grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB` to install `GRUB`

This may generate error: `EFI variables are not supported on this system`. If this is on a virtual machine, enable EFI in setting.

<img src="./img/3-12-3.png" alt="3-12-3" style="zoom:75%;" />

`grub-mkconfig -o /boot/grub/grub.cfg` to generate GRUB config file

<img src="./img/3-12-4.png" alt="3-12-4" style="zoom:75%;" />

#### network

`pacman -S networkmanager`

<img src="./img/3-13-1.png" alt="3-13-1" style="zoom:40%;" />

<img src="./img/3-13-2.png" alt="3-13-2" style="zoom:40%;" />

`systemctl enable NetworkManager` to automatically boot `NetworkManager` when booting.

<img src="./img/3-13-3.png" alt="3-13-3" style="zoom:50%;" />

Finally, `exit` and `reboot`

Login to *root* and test the network via `ping [website]`

<img src="./img/3-13-4.png" alt="3-13-4" style="zoom:50%;" />

`Ctrl`+`c` to interrupt and `pacman -Sy` to synchronize the libraries

### Install GUI Desktop: KDE as an example

For KDE, konsole is the terminal, kate is the text editor,filelight is to check disk usage, dolphin is file manager, ark is archive manager, and many other packages.

`pacman -S plasma konsole kate filelight dolphin xorg ark sudo`

(Supposedly, `sudo` should already be installed in the base package previously)

There are other packages that can be installed right now in case taking time later.

`pacman -S sddm xorg plasma konsole kate filelight dolphin ark`

(Notably, *archilinuxcn-kering* is for Chinese users)

<img src="./img/4-1-1.png" alt="4-1-1" style="zoom:40%;" />

When asking for the selection, just by defult select all.

<img src="./img/4-1-2.png" alt="4-1-2" style="zoom:40%;" />

<img src="./img/4-1-3.png" alt="4-1-3" style="zoom:40%;" />

`systemctl enable sddm` to make *sddm* (Simple Desktop Display Manager, this is what makes the machine displays in GUI)  automatically boot when booting the system.

Then `reboot`. Now we have a GUI desktop booted.

<img src="./img/4-2.png" alt="4-2" style="zoom:40%;" />

Notably, if you want Chinese or other languages, you can switch it in the settings. However, before doing this, remember to download the corresponding fonts if needed. Otherwise, the characters might become unidentified blocks.
