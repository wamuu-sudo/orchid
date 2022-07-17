# Credits : MAXYMAX!
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

STR_INVALID_CHOICE="Alegere nevalidă:"

STR_INSTALLER_STEPS="Bine ati venit|Conectarea la internet|Selectia versiuni de Orchid Linux |selectarea diskului|selectarea fisierului de system|hibernarea|selectarea placii de grafica|nume system|esync|Updates|crearea userului |parola pentru root(admin)|relua|Installare"
# Function CLI_filesystem_selector
SWAP_HIBERNATION_SWAP="SWAP-ul tău va avea o dimensiune de"
STR_WHAT_IS_FILESYSTEM="Un sistem de fișiere organizează modul în care datele sunt stocate pe disc.
Btrfs este now. Vă permite să faceți instantanee automate ale sistemului
in caz daca un update nu merge cum trebuie.
Toate datele vor fi comprimate transparent.
Este posibil să redimensionați sistemul din mers.
Ext4 este robust datorită înregistrării operațiunilor,
minimizează fragmentarea datelor și este testat pe scară largă.
"

STR_WHAT_IS_PARTITIONNING="Selectați modul de instalare:"
STR_MANUAL_PART="1) Partiționare manuală"
STR_AUTO_PART="2) Partiționare automată"
STR_PART_NUM="Selectați modul de partiționare cu numărul său, apoi apăsați ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua:"
STR_PART_MAN_WARNING="Acest mod este recomandat pentru utilizatorii avansați sau în caz de dualboot.
Dacă partițiile dvs. nu sunt deja existente, puteți utiliza instrumente precum ${COLOR_GREEN}GParted${COLOR_RESET}, ${COLOR_GREEN}Cfdisk${COLOR_RESET}, dacă este necesar, vă sugerăm cfdisk în pasul următor.
Pentru ca Orchid Linux să funcționeze trebuie să alegeți :
* Eticheta ${COLOR_RED}GPT${COLOR_RESET}
* o partiție ${COLOR_RED}$ROM${COLOR_RESET}, de tip ${COLOR_RED}\"$ROM_PARTITION\"${COLOR_RESET} cu o dimensiune recomandată de ${COLOR_RED}$ROM_SIZE${COLOR_RESET}
* o partiție ${COLOR_RED}swap${COLOR_RESET} de tip ${COLOR_RED}\"Linux swap\"${COLOR_RESET}, se recomandă o dimensiune de cel puțin ${COLOR_RED}$(swap_size_no_hibernation_man) Go${COLOR_RESET}. Dacă doriți să utilizați hibernarea, vă recomandăm cel puțin ${COLOR_RED}$(swap_size_hibernation_man) Go${COLOR_RESET},
* o partiție ${COLOR_RED} rădăcină ${COLOR_RESET} pentru Orchid Linux de cel puțin ${COLOR_RED}20 GB${COLOR_RESET}, de tip ${COLOR_RED} \"Sistem de fișiere Linux\"${COLOR_RED} \"Linux filesystem\"${COLOR_RESET}

După ce ați creat schema de partiții, nu uitați să o scrieți pe disc cu opțiunea ${COLOR_WHITE}[Write]${COLOR_RESET}.

Rețineți numele ${COLOR_WHITE}\"Device\"${COLOR_RESET}, deoarece vă vor fi solicitate mai târziu.

Apăsați ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua. "
STR_PART_CFDISK_MAN="Doriți să folosiți cfdisk pentru a partaja? [y/n]"


STR_LANGUAGE="Romana"
STR_CHOOSE_FILESYSTEM="Alegeți tipul de sistem de fișiere pe care doriți să îl instalați:  [${COLOR_GREEN}Btrfs${COLOR_RESET}]"

# Function select_filesystem_to_install

STR_SELECT_FS="Selectați sistemul de fișiere cu numărul acestuia, ${COLOR_WHITE}[Enter]${COLOR_RESET} a confirma:"

# Function CLI_orchid_selector

STR_CLI_ORCHID_SELECTOR_TEXT="Alegeți versiunea de Orchid Linux pe care doriți să o instalați:"

# Function select_orchid_version_to_install

STR_CLI_ORCHID_VER_SEL_TEXT="Selectați versiunea Orchid Linux cu numărul său, ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a valida :"

# Function CLI_selector

STR_YOUR_GPU="${COLOR_GREEN}*${COLOR_RESET}  GPUl tau:"
# Non juuuuure :O
STR_GPU_DRIVERS_SEL="Alegeți driverele GPU pe care doriți să le instalați :"

STR_GPU_DRIVERS_CHOICE="Selectați driverele pentru GPU-ul dvs. cu numărul, ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a valida :"

# Function CLI_disk_selector

STR_DISK_SEL="Alegeți discul pe care doriți să instalați Orchid Linux:
 ${COLOR_YELLOW}! AVERTIZARE ! toate datele de pe discul ales vor fi șterse !${COLOR_RESET}"
STR_DISK_SEL_MAN="Alegeți ${COLOR_GREEN}disk${COLOR_RESET} pe care doriți să-l modificați cu cfdisk"
STR_DISK_SEL_MAN_READ="Alegeți ${COLOR_GREEN}discul ${COLOR_RESET} pe care doriți să-l modificați cu numărul acestuia, apoi apăsați ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua:"
STR_DISK_SEL_MAN_BIOS="Alegeți ${COLOR_GREEN}discul ${COLOR_RESET}complet pe care doriți să îl utilizați (modul BIOS):"
STR_DISK_SEL_MAN_BIOS_NUM="Alegeți discul corespunzător cu numărul acestuia, apoi apăsați ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua: "
STR_DISK_SEL_MAN_UEFI="Alegeți partiția ${COLOR_RED}UEFI${COLOR_RESET} pe care doriți să o utilizați (UEFI Mode): "
STR_DISK_SEL_MAN_UEFI_NUM="Alegeți partiția corespunzătoare cu numărul acesteia, apoi apăsați ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua: "
STR_DISK_SEL_MAN_UEFI_VALIDATE="Doriți să formatați partiția UEFI? (Alegeți nu dacă sunteți într-un caz dualboot) [y/n]"
STR_DISK_SEL_MAN_ROOT="Alegeți partiția rădăcină ${COLOR_LIGHTBLUE} ${{COLOR_RESET} pe care doriți să o utilizați: "
STR_DISK_SEL_MAN_ROOT_NUM="Alegeți partiția corespunzătoare cu numărul acesteia, apoi apăsați ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua: "
STR_DISK_SEL_MAN_SWAP="Alegeți partiția ${COLOR_GREEN}swap${{COLOR_RESET} pe care doriți să o utilizați: "
STR_DISK_SEL_MAN_SWAP_NUM="Alegeți partiția corespunzătoare cu numărul acesteia, apoi apăsați ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua: "


# Function select_disk_to_install

STR_DISK_CHOICE="Selectați discul pentru a instala Orchid Linux cu numărul său, ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a valida:"

# Function auto_partitionning_full_disk

STR_DISK_PART="${COLOR_GREEN}*${COLOR_RESET} Partiționați discul."

STR_EFI_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatați partiția EFI."

STR_SWAP_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatați partiția de swap."

STR_BTRFS_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatați partiția Btrfs."

STR_EXT4_ERASE="${COLOR_GREEN}*${COLOR_RESET} Formatați partiția EXT4n."
# Function swap_size_hibernation

STR_HIBERNATION_DANGER="Nu vă recomandăm să folosiți hibernarea cu dvs ${RAM_SIZE_GB} GB de RAM, deoarece ar necesita o partiție SWAP a ${SWAP_SIZE_GB} GB pe disc"

STR_HIBERNATION_CONFIRM="Doriți să creați o partiție SWAP de ${SWAP_SIZE_GB} (Dacă nu, partiția SWAP va fi mult mai mică și nu veți putea folosi hibernarea) ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET} "

STR_SWAP_SIZE_QUESTION="Introduceți dimensiunea partiției SWAP pe care doriți să o creați (în GB)" # Also in function swap_size_no_hibernation

# Function create_password

STR_CREATE_PASSWORD="${COLOR_WHITE}Introduceți parola pentru utilizator: (${USERNAME}) ${COLOR_YELLOW}(parola nu va apărea)${COLOR_RESET}"
STR_CREATE_PASSWORD_ROOT="${COLOR_WHITE}Introduceți parola pentru utilizator: (Root) ${COLOR_YELLOW}(parola nu va apărea)${COLOR_RESET}"

STR_CREATE_PASSWORD_REPEAT="${COLOR_WHITE}Introduceți parola din nou pentru a o confirma:${COLOR_RESET}"

# Function verify_password_concordance

STR_CREATE_PASSWORD_FAIL="${COLOR_YELLOW}Parolele nu se potrivesc, încercați din nou.${COLOR_RESET}"

# Main part of the install script below

STR_USE_THE_GODDAMN_SUDO="Vă rugăm să reporniți cu privilegii root. (su sau sudo)"

STR_WELCOME="${COLOR_YELLOW}Echipa Orchid Linux nu este în niciun fel responsabilă pentru niciunul
pentru orice probleme care pot apărea în timpul instalării sau utilizării
instalarea sau utilizarea Orchid Linux.
(Licență GPL 3.0 sau mai mare)
Vă rugăm să citiți instrucțiunile cu mare atenție.
Vă mulțumim că ați ales Orchid Linux!${COLOR_RESET}"

STR_WELCOME_START="Apasă ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a începe instalarea."

STR_RAM_ISSUE="${COLOR_YELLOW}Ne pare rău, aveți nevoie de cel puțin 2 GB de RAM pentru a utiliza Orchid Linux. Sfârșitul instalării.${COLOR_RESET}"

STR_INTERNET_FAIL="${COLOR_RED}*${COLOR_RESET} Test de conexiune la internet KO. Fie nu aveți nicio conexiune la internet, fie serverul nostru nu este."

STR_INTERNET_FAIL_CONTINUE="Vom încerca să vă găsim o conexiune la internet; apasă${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua"
STR_INTERNET_SUCCESS="${COLOR_GREEN}*${COLOR_RESET} Conexiunea la internet este funcțională."

STR_CONTINUE="apasă ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua"

STR_CHANGE_KEYMAP="${COLOR_GREEN}*${COLOR_RESET} schimbatiți tastatura la(ro)."

STR_DISK_WARNING_INST="${COLOR_GREEN}*${COLOR_RESET} Orchid Linux se va instala pe ${COLOR_GREEN}"
STR_DISK_WARNING_INST_2="${COLOR_YELLOW} ^^! AVERTIZARE ! toate datele de pe acest disc vor fi șterse!${COLOR_RESET}"

STR_DISK_ROM="${COLOR_GREEN}*${COLOR_RESET} Tipul de pornire a sistemului de operare este:"

STR_DISK_ROM_2="apasă ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a continua, ${COLOR_WHITE}sau orice altă cheie${COLOR_RESET} pentru a ieși din programul de instalarea."

STR_ORCHID_CANCEL="${COLOR_YELLOW}Instalarea Orchid Linux a fost anulată. Discurile tale nu au fost scrise. Sperăm să te vedem curând!"${COLOR_RESET}

STR_WHAT_IS_HIBERNATION="Hibernarea închide computerul în timp ce își menține starea.
Când îl porniți, desktopul va fi exact ca înainte să îl închideți.
Pentru a face acest lucru, este necesar să copiați toată memoria RAM pe un disc (SWAP).
În mod implicit, vă sugerăm să nu utilizați hibernation.
"
STR_USE_HIBERNATION_QUESTION="Doriți să puteți utiliza hibernarea ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_YOUR_SWAP_SIZE=" ${COLOR_GREEN}*${COLOR_RESET} SWAP-ul tău va avea dimensiunea de ${SWAP_SIZE_GB} GB."

STR_WHAT_IS_HOSTNAME="Numele de gazdă este numele dat computerului dvs. din rețea,
pentru a-l identifica în timpul comunicării.
În mod implicit, vă sugerăm să îl sunați ${COLOR_GREEN}orchid${COLOR_RESET}.
"
STR_CHOOSE_HOSTNAME="Introduceți numele acestui sistem (nume de gazdă) pentru a-l identifica în rețea [${COLOR_GREEN}orchid${COLOR_RESET}]:"

STR_INCORRECT_HOSTNAME="${COLOR_RED}*${COLOR_RESET} Îmi pare rău, (${COLOR_WHITE}${HOSTNAME}${COLOR_RESET}) este invalid. Vă rugăm să încercați din nou."

STR_WHAT_IS_ESYNC="Esync este o tehnologie creată pentru a îmbunătăți performanța jocurilor
care folosesc intens paralelismul. Este util mai ales dacă folosiți computerul pentru jocuri.
dacă folosești computerul pentru jocuri.
Necesită o mică modificare a unui parametru de securitate
(creșterea semnificativă a numărului de descriptori de fișiere pe proces).
În mod implicit, vă sugerăm să îl activați: ${COLOR_GREEN}o${COLOR_RESET}.
"

STR_ESYNC_GAMING="Pentru edițiile Gaming, Orchid Linux activează automat esync.
"


STR_ESYNC_CONFIGURE="Doriți să vă configurați instalarea cu esync? ${COLOR_WHITE}[${COLOR_GREEN}d${COLOR_WHITE}/n]${COLOR_RESET}"

STR_WHAT_IS_UPDATE="Actualizarea computerului este o operațiune care constă în verificare
că software-ul de pe computer utilizează cea mai recentă versiune disponibilă.
Acest lucru este deosebit de important pentru securitatea sistemului,
consecvență și oferă uneori funcții noi.
În mod implicit, vă sfătuim să faceți actualizarea imediat după instalare,
deoarece această operațiune poate fi consumatoare de timp și dacă alegeți să o faceți în timpul instalării
instalarea va trebui să așteptați fără a putea face nimic altceva.
"

STR_UPDATE_QUESTION="Doriți să vă actualizați Orchid Linux în timpul acestei instalări? ${COLOR_WHITE}[o/${COLOR_GREEN}n${COLOR_WHITE}]${COLOR_RESET}"

STR_WHAT_IS_USERNAME="Pe un sistem Linux, precum Orchid Linux, fiecare utilizator trebuie să aibă
cont care îi identifică și le separă fișierele de altele.
În mod implicit, primul utilizator pe care îl creați va avea
drepturi de administrare cu comanda ${COLOR_WHITE}sudo${COLOR_RESET}.
"

STR_USERNAME_SELECT="${COLOR_GREEN}*${COLOR_RESET} ${COLOR_WHITE}Numele contului pe care doriți să-l creați: ${COLOR_RESET}"


STR_INCORRECT_USERNAME="${COLOR_RED}*${COLOR_RESET} scuze ${COLOR_WHITE}${USERNAME}${COLOR_RESET} este invalid. Vă rugăm să încercați din nou."

STR_WHAT_IS_ROOT="Acum veți alege parola pentru utilizatorul root.
Acest cont special are drepturi complete asupra computerului."
STR_RESUME_INST="${COLOR_WHITE}Rezumatul instalării${COLOR_RESET}"
STR_RESUME_CONNEXION_TEST="Test de conexiune la internet: [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_EDITION="Versiunea Orchid Linux aleasă:"
STR_RESUME_KEYBOARD="Comutați tastatura la ${COLOR_GREEN}(ro)${COLOR_RESET}: [${COLOR_GREEN}OK${COLOR_RESET}]"
STR_RESUME_DISK="Orchid Linux se va instala pe:"
STR_RESUME_FS="Sistemul de fișiere ales este:"
STR_RESUME_HIBERNATION="Veți putea folosi ${COLOR_GREEN}hibernare${COLOR_RESET}: memorie de ${RAM_SIZE_GB} GB, ${PROCESSORS}coruri CPU, SWAP de ${COLOR_GREEN} ${SWAP_SIZE_GB} GB${COLOR_RESET}"
STR_RESUME_HIBERNATIONNOT="Memoria ta are o dimensiune de ${RAM_SIZE_GB} GB, ${PROCESSORS}coruri CPU, SWAP de ${COLOR_GREEN}${SWAP_SIZE_GB} GB${COLOR_RESET}"

STR_RESUME_GPU="Vor fi instalate următoarele drivere grafice:"
STR_RESUME_HOSTNAME="În rețea, acest sistem va fi numit:"
STR_RESUME_ESYNC=" ${COLOR_GREEN}esync${COLOR_RESET} configurarea se va face pentru cont:"
STR_RESUME_UPDATE="Orchid Linux va fi ${COLOR_GREEN}la curent${COLOR_RESET} în timpul acestei instalări.
                                ^^ ${COLOR_YELLOW}Acest lucru poate dura mult timp.${COLOR_RESET}"
STR_RESUME_USERNAME="Pe lângă superutilizatorul root, va fi creat contul pentru următorul utilizator:"
STR_INSTALL_BEGIN="apasa ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a începe instalarea pe disc, ${COLOR_WHITE} sau orice altă cheie${COLOR_RESET} pentru a ieși din programul de instalare."
STR_INSTALL_CANCEL="${COLOR_YELLOW}Instalarea Orchid Linux a fost anulată. Discurile tale nu au fost scrise. Sperăm să te vedem curând!"${COLOR_RESET}
STR_INSTALL_MOUNTING="${COLOR_GREEN}*${COLOR_RESET} Montaj partiti"
STR_INSTALL_MOUNTING_ROOT="${COLOR_GREEN}*${COLOR_RESET} partitia root."
STR_INSTALL_MOUNTING_SWAP=" ${COLOR_GREEN}*${COLOR_RESET} activare SWAP."
STR_INSTALL_MOUNTING_EFI=" ${COLOR_GREEN}*${COLOR_RESET} partitie EFI ."
STR_INSTALL_MOUNTING_PART_STOP="${COLOR_GREEN}*${COLOR_RESET} Partiționare finalizată!"
STR_INSTALL_EXTRACT="${COLOR_GREEN}*${COLOR_RESET} Descărcarea și extragerea versiunii Orchid Linux aleasă."
STR_INSTALL_EXTRACT_FINISH="${COLOR_GREEN}*${COLOR_RESET} Extracție finalizată."
STR_INSTALL_SYS_MOUNT="${COLOR_GREEN}*${COLOR_RESET} Montăm folderele proc, dev, sys și run pentru chroot."
STR_ENDING="Instalare finalizată! ${COLOR_WHITE}[Enter]${COLOR_RESET} pentru a reporni. Vă rugăm să nu uitați să îndepărtați mediul de instalare. Vă mulțumim că ne-ați ales!"
