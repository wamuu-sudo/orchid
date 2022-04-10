# Orchid Linux tools


![Orchid Logo](img/Orchid-Think.png)

## Our tools :

We integrate commands that allow the usage and maintenance of the system easily and fastly.

### orchid-sync

This is the main tool because it let the system update everything in it.
Basically this tool synchronises the different sub-repos of Orchid :

- Les fonds d'écrans. (d'origine diverses)
- Wallpapers.
- The tools.
- DWM if you have chosen it.
- Gaming tools if you have them.

This command is used by running  `orchid-sync`.

### orchid-install

This command lets you install a package.
Basically, it's an alias for `emerge -av --autounmask=y --autounmask-write`.
This auto-unmasks masked packages.

And its used like so:
 ```
sudo orchid-install packagename
 ```

### orchid-delete

This command deletes and cleans the specificied package.
Basically, it's an alias for`emerge -C && emerge --depclean`.
It cleans dependencies and other stuff after uninstalling

And its used like so:
 ```
sudo orchid-delete packagename
 ```

### orchid-update

This command lets you update the WHOLE system
Basically, it's an alias for `eix-sync && emerge -avuDN @world`.

And its used like so:
 ```
sudo orchid-update
 ```
### orchid-update-sleep

This tool lets you update the WHOLE system, and shutdown your device after the install
Basically, an alias for `eix-sync && emerge -avuDN @world && shutdown -h now `.

And its used like this:
```
sudo orchid-update-sleep
```

### orchid-boot-update

This command updates grub, especially useful after a new kernel install.
Basically, it's an alias for `grub-mkconfig -o /boot/grub/grub.cfg`.

And its used like so:
 ```
sudo orchid-boot-update
 ```


### orchid-kernel-up

This commands autorises the installation of the masked Kernels, for exemple the 5.16.17.
This command by itself doesn't install anything, we need to launch a system update after that.

And its used like so:
 ```
sudo orchid-kernel-up
 ```

### orchid-nvidia

This command let you use the newest and latest nvidia drivers.
On it own, this tool doesn't install anything, we need to launch a system update after that.

And its used like so:
 ```
sudo orchid-nvidia
 ```
### orchid-get-tkg (NEW!!)

This command downloads all the dependencies, tools and files you need for a working linux-tkg experience and update the existing install if found 
By it own, this command does nothing apparent, so you will have to run the `orchid-set-tkg`

Usage:
```
sudo orchid-get-tkg
```

### orchid-set-tkg (NEW!!)
This command needs to be ran after the `orchid-get-tkg` command to update the kernel version, sync the repo, and runs the setup and compilation script.

This tool is to be used like this:
```
sudo orchid-set-tkg
```

## Contributors

- [Hydaelyn](https://github.com/wamuu-sudo) : Founder of the project.
- Vinceff : Documentation & projet management , communication director.
- [Chevek](https://github.com/chevek) : Gaming tools and Optimisation.
- [Babilinx](https://github.com/babilinx) : Project Optimisation.
- Piaf_Jaune : Graphist & Look'n Feel.
- Kirik : Documentation verification.
- [Crystal](https://archenagechan.github.io) : English translation.
- All the users of  [Discord Gaming Linux FR](https://discord.gg/KAzznM4Fnb).
