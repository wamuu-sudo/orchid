# Installation of Orchid Linux

Orchid is a modern and sleek Gentoo variant, for computers and laptops.

![Orchid Logo](img/Orchid-Think.png)

## Download & run the LiveCD

Since we don't have a special ISO image, we use the vanilla ISO image of Gentoo.

Note that you have two versions, a GUI and a CLI one.

Note also that the GUI version doesn't represent at all the desktop you will get.

We implemented it to help you follow this guide graphically while installing the system.

These ISO images are provided by Gentoo themselves, we aren't responsible of any dammage.

The files needed to verify the integrity of these ISO images are available [here](https://dl.orchid-linux.org).

[Download the CLI version](https://dl.orchid-linux.org/install-amd64-minimal-20220315T091810Z.iso) [~500Mo]

[Download the GUI version](https://dl.orchid-linux.org/livegui-amd64-20220315T091810Z.iso) [~5Go]

You will need to make an USB stick bootable using Rufus, Ventoy or Etcher, the choice is yours.

## Prerequisites

The device NEEDS to have access to Internet to download the archives.

## Prepare the installation

Depending on the ISO you choose, you will either have a CLI environnement, or a GUI one.

To get a French Layout, type this command (a window will automatically open in the GUI version):

```
loadkeys fr
```

Note: Replace `fr` with the name of your layout if not using AZERTY.

Verify Internet Access:

```
ip a
```

If you don't have an ip address, please send a request to your DHCP server: 

```
dhcpcd
```

If you need wireless connexion (WIFI) the ISO image provides this tool:

```
net-setup
```

## Disk Partitioning

To find the path of your drives, use:

```
fdisk -l
```

The name might change depending on your technology (sdX for sata, and nvme0nX for nvme).

```
cfdisk /dev/sdX or cfdisk /dev/nvme0nX
```

And here is the optimal scheme to use:

- A 1MB partition, non formated, and has the "Bios Boot" flag (ONLY IN BIOS INSTALLS) OR a 256MB EFI partition , formated in vfat (ONLY IN UEFI SYSTEMS).
- A Swap partition of a couple of GBs, 2 or 4 is enough.
- And the rest of the space left in ext4.

Using cfdisk is easy, so it won't be treated here.

Now we format the freshly created partitions (exemple on a sata disk, with an UEFI system):

```
mkfs.vfat -F32 /dev/sda1 (UEFI ONLY)
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
```

Now we should mount the partitions to work on them.

We mount the root partition:

```
mkdir /mnt/orchid && mount /dev/sda3 /mnt/orchid
```

Swap activation:

```
swapon /dev/sda2
```

EFI partition (Only in UEFI):

```
mkdir -p /mnt/orchid/boot/EFI && mount /dev/sda1 /mnt/orchid/boot/EFI
```

Verify date and time:

```
date
```

Correct the date and time if incorrect:

```
date MMJJhhmmAAAA
```

## Installing the full system

Let's move to the working directory:

```
cd /mnt/orchid
```

Now we need to download the archive we want for our Orchid system using wget (the archives are quite big):

[Standard DWM version](https://dl.orchid-linux.org/stage4-orchid-dwmstandard-latest.tar.bz2) [1.9Go]

[Gaming DWM version](https://dl.orchid-linux.org/stage4-orchid-dwmgaming-latest.tar.bz2) [2.9Go]

[Complete gnome version](https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.tar.bz2) [2.4Go]

Example:

```
wget https://dl.orchid-linux.org/stage4-orchid-gnomefull-latest.tar.bz2
```

Extract the downloaded archive: 

```
tar -jxvpf stage4-*.tar.bz2 --xattrs
```

## Pre-configuration of the system

We edit the make.conf to change some settings you don't like:

```
nano -w /mnt/orchid/etc/portage/make.conf
```

The /etc/portage/make.conf is the file we edit to define variables about our future architecture (core number, video card, input devices, language, USEFLAGS choice ...etc). By default, Orchid comes with a good configuration:

- GCC optimisation for a generic system.
- Use of basic fonctions such as : Pulseaudio, networkmanager, ALSA.
- Proprietary Nvidia drivers.
- French locales (change if needed).

Configuration of make.conf:

Here we put the number of cores on the CPU (replace X by the number):

```
MAKEOPTS="-jX" X being the number of cores on the CPU
```

Graphical support:

By default, Orchid supports the majority of graphical cards. But you can delete the ones you don't use (leave fbdev and vesa enabled!):

```
VIDEO_CARDS="fbdev vesa intel i915 nvidia nouveau radeon amdgpu radeonsi virtualbox vmware"
```

Save using CTRL+X and quit.

## Mouting and chrooting

Mount the proc and dev folder into `/mnt/orchid`, these are necessary for the good fonctionning of the chroot:

```
mount -t proc /proc /mnt/orchid/proc
mount --rbind /dev /mnt/orchid/dev
mount --rbind /sys /mnt/orchid/sys
```

We chroot into the system folder:

```
chroot /mnt/orchid /bin/bash
```

We now update the environnement variables: 

```
env-update && source /etc/profile
```

We add an indicator to the username so we know we are working on chroot:

```
export PS1="[chroot] $PS1"
```

We check the date again:

```
date
```

If it's incorrect, set the correct date using:

```
date MMJJhhmmAAAA
```

## The FSTAB file

The following file is super important, if you make an error here, the system will not boot:

```
nano -w /etc/fstab
```

Here is an example using the previously mentionned scheme (UEFI with a sata drive):

```
/dev/sda3               /               ext4            defaults,noatime         0 1
/dev/sda2               none            swap            sw              0 0
/dev/sda1              /boot/EFI           vfat            defaults         0 0
```

## Setting the hostname

To edit the hostname:

```
nano -w /etc/conf.d/hostname
```

## Users

Set a strong password for the root account:

```
passwd
```

We will now make a standard user, so that we can connect to our future GUI:

```
useradd -m -G users,wheel,audio,video -s /bin/bash username
```

Now let's give it a strong password:

```
passwd username
```

## Configuring the bootloader 

Now we install GRUB

UEFI:

```
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --recheck
```

Or Bios:

```
grub-install /dev/sdX
```

Generate grub.cfg:

```
grub-mkconfig -o /boot/grub/grub.cfg 
```

## Activating DWM (concerns only DWM versions)

The needed files are already on the system:

Just run this command as a *non-root user*:

```
/usr/share/orchid/fonts/applyorchidfonts && /usr/share/orchid/desktop/dwm/set-dwm
```

Slim will automatically launch dwm :) 

## Finalization

We exit the system:

```
exit
```

We delete the archive as we don't need it anymore:

```
rm -f /mnt/orchid/*.tar.gz
```

We unmount the system:

```
cd /
umount -R /mnt/orchid
```

Orchid is now installed, we can now safely `reboot`.

## Using DWM

DWM shortcuts:

* Launch DWM (Show Apps/Flatpaks List):

```Win+p```

* Open a terminal: 

```Win+Shift+Enter```

* Close focused window: 

```Win+Shift+c```

* Quit DWM (logout):

```Win+Shift+q```


## Go further

Discover our useful tools: [Our tools](https://github.com/wamuu-sudo/orchid/blob/main/TOOLS-EN.md).

Join our discord server: [Join the server](https://discord.gg/DeRhvP7M).


## Contributors

- [Hydaelyn](https://github.com/wamuu-sudo): Founder of the project.
- Vinceff: Documentation & projet management, communication director.
- [Chevek](https://github.com/chevek): Gaming tools and Optimisation.
- [Babilinx](https://github.com/babilinx): Project Optimisation.
- [Crystal](https://crystal-td.github.io): English translation.
- Piaf_Jaune: Graphist & Look'n Feel.
- Kirik: Documentation verification.
- All the users of  [Discord Gaming Linux FR](https://discord.gg/KAzznM4Fnb).
