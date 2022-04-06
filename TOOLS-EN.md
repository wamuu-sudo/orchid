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
On it own , this tool doesn't install anything, we need to launch a system update after that.

And its used like so:
 ```
sudo orchid-nvidia
 ```

## Contributors

- [Hydaelyn](https://github.com/wamuu-sudo) : Founder of the project.
- Vinceff : Documentation & projet management , communication director.
- [Chevek](https://github.com/chevek) : Gaming tools and Optimisation.
- [Babilinx](https://github.com/babilinx) : Project Optimisation.
- Piaf_Jaune : Graphist & Look'n Feel.
- Kirik : Documentation verification.
- [Crystaline on Methamphetamine](https://archenagechan.github.io) : English translation.
- All the users of  [Discord Gaming Linux FR](https://discord.gg/KAzznM4Fnb).
