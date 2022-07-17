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

STR_INVALID_CHOICE="ungültige auswahl :"

STR_INSTALLER_STEPS="Wilkommen|Verbinde mit Internet|Auswahl der Orchid Linux Edition|Festplatten auswahl|Dateisystem auswahl|Ruhemodus|Grafikkartenauswahl|System Name|esync|Updates|Nutzer erstellung|Root passwort|Fortsetzen|Installation"
# Function CLI_filesystem_selector

STR_WHAT_IS_FILESYSTEM="Ein datei system organisiert wie daten auf deinem speichermedium verwaltet werden.
Btrfs ist neu. Es erlaubt das automatische anfertigen von snapshots
vom System um es wiederherzustellen falls ein Update schief läuft.
Alle Daten werden transparent komprimiert.
Es ist möglich die Größe des Systems während es läuft zu ändern.
Ext4 ist robust dank operations logging,
minimiert daten fragmentation und ist extensiv getestet.
"
STR_WHAT_IS_PARTITIONNING="Wählen Sie den Installationsmodus:"
STR_MANUAL_PART="1) Manuelle Partitionierung"
STR_AUTO_PART="2) Automatische Partitionierung"
STR_PART_NUM="Wählen Sie den Partitionierungsmodus mit seiner Ziffer aus und drücken Sie dann ${COLOR_WHITE}[Enter]${COLOR_RESET}, um fortzufahren: "
STR_PART_MAN_WARNING="Dieser Modus wird für fortgeschrittene Benutzer oder im Falle eines Dualboots empfohlen.
Wenn Ihre Partitionen nicht bereits vorhanden sind, können Sie Werkzeuge wie ${COLOR_GREEN}GParted${COLOR_RESET}, ${COLOR_GREEN}Cfdisk${COLOR_RESET} verwenden, bei Bedarf schlagen wir Ihnen cfdisk im nächsten Schritt vor.
Damit Orchid Linux funktioniert, müssen Sie wählen:
* Das Label ${COLOR_RED}GPT${COLOR_RESET}
* eine Partition ${COLOR_RED}$ROM${COLOR_RESET}, vom Typ ${COLOR_RED}\"$ROM_PARTITION\"${COLOR_RESET} mit einer empfohlenen Größe von ${COLOR_RED}$ROM_SIZE${COLOR_RESET}.
* eine ${COLOR_RED}swap${COLOR_RESET}-Partition vom Typ ${COLOR_RED}\"Linux swap\"${COLOR_RESET}, empfehlen wir eine Größe von mindestens ${COLOR_RED}$(swap_size_no_hibernation_man) Go${COLOR_RESET}. Wenn Sie den Winterschlaf nutzen möchten, empfehlen wir mindestens ${COLOR_RED}$(swap_size_hibernation_man) Go${COLOR_RESET},
* eine ${COLOR_RED} Root-Partition ${COLOR_RESET} für Orchid Linux von mindestens ${COLOR_RED} 20 GB${COLOR_RESET}, vom Typ ${COLOR_RED} \"Linux filesystem\"${COLOR_RESET}.

Sobald Sie Ihr Partitionsschema erstellt haben, vergessen Sie nicht, es mit der Option ${COLOR_WHITE}[Write]${COLOR_RESET} auf die Festplatte zu schreiben.

Bitte notieren Sie sich die Namen der ${COLOR_WHITE} \"Device\"${COLOR_RESET}, da Sie später danach gefragt werden.

Drücken Sie ${COLOR_WHITE}[Enter]${COLOR_RESET}, um fortzufahren. "

STR_PART_CFDISK_MAN="Möchten Sie cfdisk verwenden, um die Partitionierung durchzuführen? [o/n] "


STR_LANGUAGE="German"
STR_CHOOSE_FILESYSTEM="Wählen sie die art des Dateisystems dass sie installieren wollen:  [${COLOR_GREEN}Btrfs${COLOR_RESET}]"
STR_HIBERNATION_SWAP="Ihr SWAP hat eine Größe von"
# Function select_filesystem_to_install

STR_SELECT_FS="Wählen sie das Dateisystem mit dessen Nummer, ${COLOR_WHITE}[Enter]${COLOR_RESET} to confirm:"

# Function CLI_orchid_selector

STR_CLI_ORCHID_SELECTOR_TEXT="Wählen sie die Orchid Linux Version die sie installieren wollen :"

# Function select_orchid_version_to_install

STR_CLI_ORCHID_VER_SEL_TEXT="Wählen sie die Orchid Linux version mit deren Nummer, ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate :"

# Function CLI_selector

STR_YOUR_GPU="${COLOR_GREEN}*${COLOR_RESET} Your GPU :"
# Non juuuuure :O
STR_GPU_DRIVERS_SEL="Wählen sie die Grafik Treiber die sie installieren wollen :"

STR_GPU_DRIVERS_CHOICE="Wählen sie die Treiber für ihre GPU mit deren nummer, ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate :"

# Function CLI_disk_selector

STR_DISK_SEL="Wählen sie die Festplatte auf der sie Orchid Linux installieren wollen:
 ${COLOR_YELLOW}! WARNUNG ! alle daten auf der ausgewählten Festplatte  werden gelöscht !${COLOR_RESET}"
STR_DISK_SEL_MAN="Wählen Sie die ${COLOR_GREEN}Diskette${COLOR_RESET}, die Sie ändern möchten, mit cfdisk".
STR_DISK_SEL_MAN_READ="Wählen Sie die ${COLOR_GREEN}Diskette${COLOR_RESET}, die Sie ändern möchten, mit ihrer Ziffer aus und drücken Sie dann ${COLOR_WHITE}[Enter]${COLOR_RESET}, um fortzufahren:".
STR_DISK_SEL_MAN_BIOS="Wählen Sie die komplette ${COLOR_GREEN}-Diskette ${COLOR_RESET}, die Sie verwenden möchten (BIOS-Modus): "
STR_DISK_SEL_MAN_BIOS_NUM="Wählen Sie das entsprechende Laufwerk mit seiner Ziffer und drücken Sie dann ${COLOR_WHITE}[Enter]${COLOR_RESET}, um fortzufahren: "
STR_DISK_SEL_MAN_UEFI="Wählen Sie die Partition ${COLOR_RED}UEFI${COLOR_RESET}, die Sie verwenden möchten (UEFI-Modus): "
STR_DISK_SEL_MAN_UEFI_NUM="Wählen Sie die entsprechende Partition mit ihrer Ziffer und drücken Sie dann ${COLOR_WHITE}[Enter]${COLOR_RESET}, um fortzufahren: "
STR_DISK_SEL_MAN_UEFI_VALIDATE="Möchten Sie die UEFI-Partition formatieren? (Wählen Sie "Nein", wenn Sie sich in einem Dualboot-Fall befinden) [o/n] "
STR_DISK_SEL_MAN_ROOT="Wählen Sie die Partition ${COLOR_LIGHTBLUE}racine${COLOR_RESET}, die Sie verwenden möchten: "
STR_DISK_SEL_MAN_ROOT_NUM="Wählen Sie die entsprechende Partition mit ihrer Ziffer und drücken Sie dann ${COLOR_WHITE}[Enter]${COLOR_RESET}, um fortzufahren: "
STR_DISK_SEL_MAN_SWAP="Wählen Sie die Partition ${COLOR_GREEN}swap${COLOR_RESET}, die Sie verwenden möchten: "
STR_DISK_SEL_MAN_SWAP_NUM="Wählen Sie die entsprechende Partition mit ihrer Ziffer und drücken Sie dann ${COLOR_WHITE}[Enter]${COLOR_RESET}, um fortzufahren: "


# Function select_disk_to_install

STR_DISK_CHOICE="Wählen sie die Festplatte auf der sie Orchid Linux installieren möchten mit deren number, ${COLOR_WHITE}[Enter]${COLOR_RESET} to validate :"

# Function auto_partitionning_full_disk

STR_DISK_PART="${COLOR_GREEN}*${COLOR_RESET} Partitionierung der Festplatte."

STR_EFI_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatierung der EFI partition."

STR_SWAP_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatierung der swap partition."

STR_BTRFS_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatierung der BTRFS partition."

STR_EXT4_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatierung der EXT4 partition."
# Function swap_size_hibernation

STR_HIBERNATION_DANGER="Wir empfehlen ihnen dagegen Ruhemodus mit ihren"
#{RAM_SIZE_GB}
STR_HIBERNATION_DANGER_2="GB an RAM, zu verwenden denn es bräuchte eine SWAP partition von"
#{SWAP_SIZE_GB}
STR_HIBERNATION_DANGER_3="GB auf der Festplatte"

STR_HIBERNATION_CONFIRM="Wollen sie eine SWAP partition mit der folgenden größe erstellen?"
#{SWAP_SIZE_GB}
STR_HIBERNATION_CONFIRM_2="(falls nicht, wird die SWAP partition viel kleiner und sie werden keinen Ruhemodus verwenden können) ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} "

STR_SWAP_SIZE_QUESTION="Tragen sie die Größe der  SWAP partition ein die sie erstellen wollen (in GB)" # Also in function swap_size_no_hibernation"

# Function create_password

STR_CREATE_PASSWORD="${COLOR_WHITE}Tragen sie das benutzerpasswort ein:"

STR_CREATE_PASSWORD_2="${COLOR_YELLOW}(das password wird nicht angezeigt)${COLOR_RESET}"

STR_CREATE_PASSWORD_REPEAT="${COLOR_WHITE}geben sie das passwort nochmals ein um es zu bestätigen:${COLOR_RESET}"

# Function verify_password_concordance

STR_CREATE_PASSWORD_FAIL="${COLOR_YELLOW}Passwörter sind nicht identisch, versuchen sie es nochmals.${COLOR_RESET}"

# Main part of the install script below

STR_USE_THE_GODDAMN_SUDO="Bitte starten sie mit administratorprivilegien neu. (su oder sudo)"

STR_WELCOME="${COLOR_YELLOW}Das Orchid Linux Team ist in keiner weise 
für jegliche probleme die während 
der installation oder nutzung
von Orchid Linux auftreten veratwortlich.
(Licenz GPL 3.0 oder höher)
Bitte lesen sie die instructionen mit äußerster vorsicht.
Danke für das wählen von Orchid Linux !${COLOR_RESET}"

STR_WELCOME_START="Drücken sie ${COLOR_WHITE}[Enter]${COLOR_RESET} um die installation zu beginnen."

STR_RAM_ISSUE="${COLOR_YELLOW}entschuldigung, sie brauchen mindestens 2GB an RAM um Orchid Linux zu nutzen. Ende der installation.${COLOR_RESET}"

STR_INTERNET_FAIL="${COLOR_RED}*${COLOR_RESET} Internetverbindungs test KO. Entweder sie haben keine verbindung zum the internet oder unser server ist down."

STR_INTERNET_FAIL_CONTINUE="Wir versuchen ihnen eine internetverbindung zu finden; drücken sie ${COLOR_WHITE}[Enter]${COLOR_RESET} um fortzufahren"

STR_INTERNET_SUCCESS="${COLOR_GREEN}*${COLOR_RESET} Internetverbindung erfolgreich."

STR_CONTINUE="Drücken sie ${COLOR_WHITE}[Enter]${COLOR_RESET} um fortzufahren"

STR_CHANGE_KEYMAP="${COLOR_GREEN}*${COLOR_RESET} Wechselt tatatur zu (en)."

STR_DISK_WARNING_INST="${COLOR_GREEN}*${COLOR_RESET} Orchid Linux wird auf der folgenden Festplatte installieren:  ${COLOR_GREEN}"
STR_DISK_WARNING_INST_2="${COLOR_YELLOW} ^^! WARNING ! alle Daten auf dieser Festplatte werden gelöscht !${COLOR_RESET}"

STR_DISK_ROM="${COLOR_GREEN}*${COLOR_RESET} Der Betriebssytem boot typ ist:"

STR_DISK_ROM_2="Drücken sie ${COLOR_WHITE}[Enter]${COLOR_RESET} um fortzufahren, ${COLOR_WHITE}oder eine beliebige andere taste${COLOR_RESET} um das installationsprogramm zu verlassen."

STR_ORCHID_CANCEL="${COLOR_YELLOW}Orchid Linux installation abgebrochen. ihre Festplatten wurden nicht beschrieben. Wir hoffen sie bald wiederzusehen!"${COLOR_RESET}

STR_WHAT_IS_HIBERNATION="Ruhemodus ist ein weg ihren Computer herunterzufahren während dessen jetztiger status erhalten bleibt.
Wann sie ihn wieder einschalten, wird ihr desktop genau so sein wie vor dem ausschalten.
Um dies zu ermöglichen, ist es erforderlich den Ganzen RAM auf eine Festplatte zu Kopieren (SWAP).
Auf Standard, empfehlen wir ihnen Ruhemodus nicht zu verwenden.
"
STR_USE_HIBERNATION_QUESTION="Wollen sie die möglichkeit Ruhemodus zu verwenden? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_YOUR_SWAP_SIZE=" ${COLOR_GREEN}*${COLOR_RESET} Ihr SWAP wird eine größe von ${SWAP_SIZE_GB} GB besitzen."

STR_WHAT_IS_HOSTNAME="Der hostname ist der Name der ihrem Computer auf dem netzwerk erteilt wird,
um diesen zu identifizieren.
Als Standard, empfehlen wir ihnen das sie ihn so bennenen: ${COLOR_GREEN}orchid${COLOR_RESET}.
"
STR_CHOOSE_HOSTNAME="Geben sie den namen ihres systems ein (hostname) um ihn auf dem netzwerk identifizieren zu können [${COLOR_GREEN}orchid${COLOR_RESET}]:"

STR_INCORRECT_HOSTNAME="${COLOR_RED}*${COLOR_RESET} Tut uns leid, (${COLOR_WHITE}"

# Here there will be the hostname of the user
STR_INCORRECT_HOSTNAME_2="${COLOR_RESET}) ist ungültig. Bitte versuchen sie es erneut."

STR_WHAT_IS_ESYNC="Esync ist eine Technologie erschaffen die Leistung von Spielen zu verbessern,
diese macht starken nutzen aus parallelismus. Es ist vorallem nützlich wenn sie ihren Computer für das gaming benutzen.
Es setzt eine kleine modifikation an einem sicherheits parameter vorraus
(dies wird die nummer der datei descriptoren pro prozess signifikant erhöhen).
Als Standard, empfehlen wir es zu aktivieren: ${COLOR_GREEN}o${COLOR_RESET}.
"

STR_ESYNC_GAMING="Für Gaming editionen aktiviert Orchid Linux automatisch esync.
"


STR_ESYNC_CONFIGURE="Wollen sie to ihre Installation mit esync konfigurieren? ${COLOR_WHITE}[${COLOR_GREEN}o${COLOR_WHITE}/n]${COLOR_RESET}"

STR_WHAT_IS_UPDATE="Das Updaten ihres Computers ist eine Operation die daraus besteht zu verifizieren
das die software auf ihrem Computer die neuste verfügbare version benutzt.
Dies ist besonders wichtig für die Systemsicherheit,
konsistenz und bring ab und zu neue funktionen.
Als Standard, empfehlen wir ihnen das update direkt nach der installation durchzuführen,
weil diese Operation zeit in anspruch nimmt und wenn sie dies während der Installation machen,
Sie vor dem abschließen der Installation warten müssen, da sie sonst warten müssen ohne etwas anderes tun zu können.
"

STR_UPDATE_QUESTION="Wollen sie ihr Orchid Linux während dieser Installation upgraden? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_WHAT_IS_USERNAME="Auf einem Linux System, wie Orchid Linux, muss jeder Nutzer einen eigenen account haben
der diese identifiziert und ihre Dateien von einander getrennt hällt.
Als Standard, wird der erste Nutzer den sie erstellen 
administrator rechte mit dem folgenen kommando erhalten: ${COLOR_WHITE}sudo${COLOR_RESET}.
"

STR_USERNAME_SELECT="${COLOR_GREEN}*${COLOR_RESET} ${COLOR_WHITE}Name des the accounts den sie erstellen wollen: ${COLOR_RESET}"


STR_INCORRECT_USERNAME="${COLOR_RED}*${COLOR_RESET} Entschuldigung ${COLOR_WHITE}"
# Here there will be the Username of the users
STR_INCORRECT_USERNAME_2="${COLOR_RESET} ist ungültig. Bitte versuchen sie es erneut."

STR_WHAT_IS_ROOT="Sie werden jetzt das passwort für den root nutzer erstellen.
Dieser account hat volle rechte über ihren Computer."
STR_RESUME_INST="${COLOR_WHITE}Installation Summary${COLOR_RESET}"
STR_RESUME_CONNEXION_TEST="Internet verbindungstest: [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_EDITION="gewählte Orchid Linux version:"
STR_RESUME_KEYBOARD="tastatur wechsel zu ${COLOR_GREEN}(en)${COLOR_RESET}: [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_DISK="Orchid Linux wird  installiert auf:"
STR_RESUME_FS="Das gewählte Dateisystem ist:"
STR_RESUME_HIBERNATION="Sie werden zur nutzung folgender ressourcen in der lage sein: ${COLOR_GREEN}hibernation${COLOR_RESET}: arbeitsspeicher von"
# Here we show the user his RAM + His CPU cores
STR_RESUME_HIBERNATION_2="CPU kerne von, SWAP von ${COLOR_GREEN}"
STR_RESUME_HIBERNATIONNOT="ihr arbeitsspeicher hat eine größe von"
# Here we show the user his RAM + His CPU cores
STR_RESUME_HIBERNATIONNOT_2="CPU kerne, SWAP von ${COLOR_GREEN}"


STR_RESUME_GPU="Die folgenden grafiktreiber werden installiert:"
STR_RESUME_HOSTNAME="Auf diesem netzwerk wird das system so bennant:"
STR_RESUME_ESYNC="The ${COLOR_GREEN}esync${COLOR_RESET} konfiguration wird für diesen account ausgefürht:"
STR_RESUME_UPDATE="Orchid Linux wird ge ${COLOR_GREEN}updated${COLOR_RESET} während dieser Installation.
                                ^^ ${COLOR_YELLOW}Dies könnte viel zeit beanspruchen.${COLOR_RESET}"
STR_RESUME_USERNAME="In ergänzung zum root superuser, wird folgender account für folgenden nutzer erstellt: "
STR_INSTALL_BEGIN="Drücken sie ${COLOR_WHITE}[Enter]${COLOR_RESET} um die Installation auf der Festplatte auszuführen, ${COLOR_WHITE} oder eine beliebige Taste ${COLOR_RESET} um das Installationsprogramm zu verlassen."
STR_INSTALL_CANCEL="${COLOR_YELLOW}Orchid Linux Installation abgebrochen. ihre Festplatten wurden nicht beschrieben. Wir hoffen sie bald wiederzusehen!"${COLOR_RESET}
STR_INSTALL_MOUNTING="${COLOR_GREEN}*${COLOR_RESET} Mounte partition:"
STR_INSTALL_MOUNTING_ROOT="${COLOR_GREEN}*${COLOR_RESET} Root partition."
STR_INSTALL_MOUNTING_SWAP=" ${COLOR_GREEN}*${COLOR_RESET} SWAP activation."
STR_INSTALL_MOUNTING_EFI=" ${COLOR_GREEN}*${COLOR_RESET} EFI partition."
STR_INSTALL_MOUNTING_PART_STOP="${COLOR_GREEN}*${COLOR_RESET} Partitionierung abgeschlossen!"
STR_INSTALL_EXTRACT="${COLOR_GREEN}*${COLOR_RESET} Downloade und extrahiere die gewählte Orchid Linux version."
STR_INSTALL_EXTRACT_FINISH="${COLOR_GREEN}*${COLOR_RESET} Extraktion abgeschlossen."
STR_INSTALL_SYS_MOUNT="${COLOR_GREEN}*${COLOR_RESET} Wir binden die the proc, dev, sys und run ordner für den chroot ein."
STR_ENDING="Installation fertig! ${COLOR_WHITE}[Enter]${COLOR_RESET} für den Neustart. Bitte vergessen sie nicht das Installationsmedium zu entfernen. Danke das sie uns gewählt haben!"
