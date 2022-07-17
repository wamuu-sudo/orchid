#!/usr/bin/env bash
if [ -d /sys/firmware/efi ]; then	                                                    # Test for UEFI or BIOS
		ROM="UEFI"
        ROM_PARTITION="EFI System"
        ROM_SIZE="512MB"
	else
		ROM="BIOS"
        ROM_PARTITION="BIOS boot"
        ROM_SIZE="8MB"
fi

# Common used strings

STR_INVALID_CHOICE="Invalid choice :"
STR_HIBERNATION_SWAP="Your SWAP will have a size of"
STR_INSTALLER_STEPS="Welcome|Connecting to internet|Selection of the Orchid Linux Edition|Disk selection|File system selection|Hibernation|Graphics card selection|System name|esync|Updates|User creation|Root password|Resume|Installation"
# Function CLI_filesystem_selector

STR_WHAT_IS_FILESYSTEM="A file system organizes the way data is stored on your disk.
Btrfs is new. It allows you to take automatic snapshots of the system
of the system to revert if an update goes wrong.
All data will be compressed transparently.
It is possible to resize the system on the fly.
Ext4 is robust thanks to operation logging,
minimizes data fragmentation and is widely tested.
"
STR_WHAT_IS_PARTITIONNING="Select the installation mode:"
STR_MANUAL_PART="1) Manual partitioning"
STR_AUTO_PART="2) Automatic partitioning"
STR_PART_NUM="Select the partitioning mode with its number, then press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue:"
STR_PART_MAN_WARNING="This mode is recommended for advanced users, or in case of dualboot.
If your partitions are not already existing, you can use tools like ${COLOR_GREEN}GParted${COLOR_RESET}, ${COLOR_GREEN}Cfdisk${COLOR_RESET}, if needed, we suggest cfdisk in the next step.
For Orchid Linux to work you need to choose :
* the label ${COLOR_RED}GPT${COLOR_RESET}
* a ${COLOR_RED}$ROM${COLOR_RESET} partition, of type ${COLOR_RED}\"$ROM_PARTITION\"${COLOR_RESET} with a recommended size of ${COLOR_RED}$ROM_SIZE${COLOR_RESET}
* a ${COLOR_RED}swap${COLOR_RESET} partition of type ${COLOR_RED}\"Linux swap\"${COLOR_RESET}, we recommend a size of at least ${COLOR_RED}$(swap_size_no_hibernation_man) Go${COLOR_RESET}. If you want to use hibernation we recommend at least ${COLOR_RED}$(swap_size_hibernation_man) Go${COLOR_RESET},
* a ${COLOR_RED}root partition${COLOR_RESET} for Orchid Linux of at least ${COLOR_RED}20 GB${COLOR_RESET}, of type ${COLOR_RED} \"Linux filesystem\"${COLOR_RESET}

Once your partition scheme is done, don't forget to write it to the disk with the ${COLOR_WHITE}[Write]${COLOR_RESET} option.

Please note the names of the ${COLOR_WHITE}\"Device\"${COLOR_RESET}, because you will be asked for them later.

Press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue."

STR_PART_CFDISK_MAN="Do you want to use cfdisk in order to proceed with partitioning? [y/n]"

STR_LANGUAGE="English"
STR_CHOOSE_FILESYSTEM="Choose the type of file system you want to install:  [${COLOR_GREEN}Btrfs${COLOR_RESET}]"

# Function select_filesystem_to_install

STR_SELECT_FS="Select the file system with its number, ${COLOR_WHITE}[Enter]${COLOR_RESET} to confirm:"

# Function CLI_orchid_selector

STR_CLI_ORCHID_SELECTOR_TEXT="Choose the version of Orchid Linux you want to install :"

# Function select_orchid_version_to_install

STR_CLI_ORCHID_VER_SEL_TEXT="Select the Orchid Linux version with its number, ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate :"

# Function CLI_selector

STR_YOUR_GPU="${COLOR_GREEN}*${COLOR_RESET} Your GPU :"
# Non juuuuure :O
STR_GPU_DRIVERS_SEL="Choose the GPU drivers you want to install :"

STR_GPU_DRIVERS_CHOICE="Select the drivers for your GPU with their number, ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate :"

# Function CLI_disk_selector

STR_DISK_SEL="Choose the disk on which you want to install Orchid Linux :
 ${COLOR_YELLOW}! WARNING ! all data on the chosen disk will be erased !${COLOR_RESET}"
STR_DISK_SEL_MAN="Choose the ${COLOR_GREEN}disk${COLOR_RESET} you want to modify with cfdisk"
STR_DISK_SEL_MAN_READ="Choose the ${COLOR_GREEN}disk${COLOR_RESET} you want to modify with its number, then press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue:"
STR_DISK_SEL_MAN_BIOS="Choose the ${COLOR_GREEN}complete ${COLOR_RESET}disk you want to use (BIOS Mode):"
STR_DISK_SEL_MAN_BIOS_NUM="Choose the corresponding disk with its number, then press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue: "
STR_DISK_SEL_MAN_UEFI="Choose the ${COLOR_RED}UEFI${COLOR_RESET} partition you want to use (UEFI Mode): "
STR_DISK_SEL_MAN_UEFI_NUM="Choose the corresponding partition with its number, then press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue: "
STR_DISK_SEL_MAN_UEFI_VALIDATE="Do you want to format the UEFI partition? (Choose no if you are in a dualboot case) [y/n]"
STR_DISK_SEL_MAN_ROOT="Choose the ${COLOR_LIGHTBLUE} root${COLOR_RESET} partition you want to use: "
STR_DISK_SEL_MAN_ROOT_NUM="Choose the corresponding partition with its number, then press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue: "
STR_DISK_SEL_MAN_SWAP="Choose the ${COLOR_GREEN}swap${COLOR_RESET} partition you want to use: "
STR_DISK_SEL_MAN_SWAP_NUM="Choose the corresponding partition with its number, then press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue: "


# Function select_disk_to_install

STR_DISK_CHOICE="Select the disk to install Orchid Linux with its number, ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate :"

# Function auto_partitionning_full_disk

STR_DISK_PART="${COLOR_GREEN}*${COLOR_RESET} Partition the disk."

STR_EFI_ERASE="${COLOR_GREEN}*${COLOR_RESET} Format the EFI partition."

STR_SWAP_ERASE="${COLOR_GREEN}*${COLOR_RESET} Format swap partition."

STR_BTRFS_ERASE="${COLOR_GREEN}*${COLOR_RESET} Format Btrfs partition."

STR_EXT4_ERASE="${COLOR_GREEN}*${COLOR_RESET} Format EXT4 partition."
# Function swap_size_hibernation

STR_HIBERNATION_DANGER="We do not recommend using hibernation with your"
#{RAM_SIZE_GB}
STR_HIBERNATION_DANGER_2="GB of RAM, as it would require a SWAP partition of"
#{SWAP_SIZE_GB}
STR_HIBERNATION_DANGER_3="GB on the disk"

STR_HIBERNATION_CONFIRM="Do you want to create a SWAP partition of"
#{SWAP_SIZE_GB}
STR_HIBERNATION_CONFIRM_2="(If not, the SWAP partition will be much smaller and you will not be able to use hibernation) ${COLOR_WHITE}[y/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} "

STR_SWAP_SIZE_QUESTION="Enter the size of the SWAP partition you want to create (in GB)" # Also in function swap_size_no_hibernation

# Function create_password

STR_CREATE_PASSWORD="${COLOR_WHITE}Enter the password for the user:"

STR_CREATE_PASSWORD_2="${COLOR_YELLOW}(the password won't appear)${COLOR_RESET}"

STR_CREATE_PASSWORD_REPEAT="${COLOR_WHITE}Enter the password again to confirm it :${COLOR_RESET}"

# Function verify_password_concordance

STR_CREATE_PASSWORD_FAIL="${COLOR_YELLOW}Passwords don't match, try again.${COLOR_RESET}"

# Main part of the install script below

STR_USE_THE_GODDAMN_SUDO="Please reboot with root privileges. (su or sudo)"

STR_WELCOME="${COLOR_YELLOW}The Orchid Linux team is in no way responsible for any
for any problems that may occur while installing or using
installation or use of Orchid Linux.
(License GPL 3.0 or higher)
Please read the instructions very carefully.
Thank you for choosing Orchid Linux !${COLOR_RESET}"

STR_WELCOME_START="Press ${COLOR_WHITE}[Enter]${COLOR_RESET} to begin the installation."

STR_RAM_ISSUE="${COLOR_YELLOW}Sorry, you need at least 2GB of RAM to use Orchid Linux. End of installation.${COLOR_RESET}"

STR_INTERNET_FAIL="${COLOR_RED}*${COLOR_RESET} Internet connection test KO. Either you have no connection to the internet or our server is down."

STR_INTERNET_FAIL_CONTINUE="We'll try to find you a connection to the internet; press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue"

STR_INTERNET_SUCCESS="${COLOR_GREEN}*${COLOR_RESET} Internet connection is functional."

STR_CONTINUE="Press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue"

STR_CHANGE_KEYMAP="${COLOR_GREEN}*${COLOR_RESET} Switch keyboard to (en)."

STR_DISK_WARNING_INST="${COLOR_GREEN}*${COLOR_RESET} Orchid Linux will install on ${COLOR_GREEN}"
STR_DISK_WARNING_INST_2="${COLOR_YELLOW} ^^! WARNING ! all data on this disk will be erased !${COLOR_RESET}"

STR_DISK_ROM="${COLOR_GREEN}*${COLOR_RESET} The operating system boot type is:"

STR_DISK_ROM_2="Press ${COLOR_WHITE}[Enter]${COLOR_RESET} to continue, ${COLOR_WHITE}or any other key${COLOR_RESET} to exit the installer."

STR_ORCHID_CANCEL="${COLOR_YELLOW}Orchid Linux installation cancelled. Your disks have not been written. We hope to see you soon!"${COLOR_RESET}

STR_WHAT_IS_HIBERNATION="Hibernation is shutting down the computer while maintaining its state.
When you turn it on, your desktop will be exactly as it was before you shut it down.
To do this, it is necessary to copy all the RAM to a disk (SWAP).
By default, we suggest that you do not use hibernation.
"
STR_USE_HIBERNATION_QUESTION="Do you want to be able to use hibernation ${COLOR_WHITE}[y/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_YOUR_SWAP_SIZE=" ${COLOR_GREEN}*${COLOR_RESET} Your SWAP will have a size of ${SWAP_SIZE_GB} GB."

STR_WHAT_IS_HOSTNAME="The hostname is the name given to your computer on the network,
to identify it during communications.
By default, we suggest you call it ${COLOR_GREEN}orchid${COLOR_RESET}.
"
STR_CHOOSE_HOSTNAME="Enter the name of this system (hostname) to identify it on the network [${COLOR_GREEN}orchid${COLOR_RESET}]:"

STR_INCORRECT_HOSTNAME="${COLOR_RED}*${COLOR_RESET} Sorry, (${COLOR_WHITE}"
# Here there will be the hostname of the user
STR_INCORRECT_HOSTNAME_2="${COLOR_RESET}) is invalid. Please try again."

STR_WHAT_IS_ESYNC="Esync is a technology created to improve the performance of games
that make heavy use of parallelism. It is especially useful if you use your computer for gaming.
if you use your computer for gaming.
It requires a small modification of a security parameter
(the significant increase of the number of file descriptors per process).
By default, we suggest you enable it: ${COLOR_GREEN}y${COLOR_RESET}.
"

STR_ESYNC_GAMING="For Gaming editions, Orchid Linux automatically enables esync.
"


STR_ESYNC_CONFIGURE="Do you want to configure your installation with esync? ${COLOR_WHITE}[${COLOR_GREEN}y${COLOR_WHITE}/n]${COLOR_RESET}"

STR_WHAT_IS_UPDATE="Updating your computer is an operation that consists of verifying
that the software on your computer is using the latest version available.
This is particularly important for system security,
consistency and sometimes provides new features.
By default, we advise to do the update right after the installation,
because this operation can be time consuming and if you choose to do it during the installation
installation you will have to wait without being able to do anything else.
"

STR_UPDATE_QUESTION="Do you want to upgrade your Orchid Linux during this installation? ${COLOR_WHITE}[y/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_WHAT_IS_USERNAME="On a Linux system, like Orchid Linux, each user must have
account that identifies them and separates their files from others.
By default, the first user you create will have
administration rights with the command ${COLOR_WHITE}sudo${COLOR_RESET}.
"

STR_USERNAME_SELECT="${COLOR_GREEN}*${COLOR_RESET} ${COLOR_WHITE}Name of the account you want to create: ${COLOR_RESET}"


STR_INCORRECT_USERNAME="${COLOR_RED}*${COLOR_RESET} Sorry ${COLOR_WHITE}"
# Here there will be the Username of the users
STR_INCORRECT_USERNAME_2="${COLOR_RESET} is invalid. Please try again."

STR_WHAT_IS_ROOT="You will now choose the password for the root user.
This particular account has full rights to the computer."
STR_RESUME_INST="${COLOR_WHITE}Installation Summary${COLOR_RESET}"
STR_RESUME_CONNEXION_TEST="Internet connection test: [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_EDITION="Orchid Linux version chosen:"
STR_RESUME_KEYBOARD="Switch keyboard to ${COLOR_GREEN}(en)${COLOR_RESET}: [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_DISK="Orchid Linux will install on:"
STR_RESUME_FS="The chosen file system is:"
STR_RESUME_HIBERNATION="You will be able to use the ${COLOR_GREEN}hibernation${COLOR_RESET}: memory of"
# Here we show the user his RAM + His CPU cores
STR_RESUME_HIBERNATION_2="CPU cores, SWAP of ${COLOR_GREEN}"
STR_RESUME_HIBERNATIONNOT="Your memory has a size of"
# Here we show the user his RAM + His CPU cores
STR_RESUME_HIBERNATIONNOT_2="CPU cores, SWAP of ${COLOR_GREEN}"


STR_RESUME_GPU="The following graphics drivers will be installed:"
STR_RESUME_HOSTNAME="On the network, this system will be named:"
STR_RESUME_ESYNC="The ${COLOR_GREEN}esync${COLOR_RESET} configuration will be done for the account:"
STR_RESUME_UPDATE="Orchid Linux will be ${COLOR_GREEN}updated${COLOR_RESET} during this installation.
                                ^^ ${COLOR_YELLOW}This may take a long time.${COLOR_RESET}"
STR_RESUME_USERNAME="In addition to the root superuser, the account for the following user will be created: "
STR_INSTALL_BEGIN="Press ${COLOR_WHITE}[Enter]${COLOR_RESET} to start the installation on the disk, ${COLOR_WHITE} or any other key${COLOR_RESET} to exit the installer."
STR_INSTALL_CANCEL="${COLOR_YELLOW}Orchid Linux installation cancelled. Your disks have not been written. We hope to see you soon!"${COLOR_RESET}
STR_INSTALL_MOUNTING="${COLOR_GREEN}*${COLOR_RESET} Mounting partitions:"
STR_INSTALL_MOUNTING_ROOT="${COLOR_GREEN}*${COLOR_RESET} Root partition."
STR_INSTALL_MOUNTING_SWAP=" ${COLOR_GREEN}*${COLOR_RESET} SWAP activation."
STR_INSTALL_MOUNTING_EFI=" ${COLOR_GREEN}*${COLOR_RESET} EFI partition."
STR_INSTALL_MOUNTING_PART_STOP="${COLOR_GREEN}*${COLOR_RESET} Partitioning complete!"
STR_INSTALL_EXTRACT="${COLOR_GREEN}*${COLOR_RESET} Downloading and extracting the chosen Orchid Linux version."
STR_INSTALL_EXTRACT_FINISH="${COLOR_GREEN}*${COLOR_RESET} Extraction complete."
STR_INSTALL_SYS_MOUNT="${COLOR_GREEN}*${COLOR_RESET} We are mounting the proc, dev, sys and run folders for the chroot."
STR_ENDING="Installation complete! ${COLOR_WHITE}[Enter]${COLOR_RESET} to reboot. Please remember to remove the installation media. Thank you for choosing us!"
