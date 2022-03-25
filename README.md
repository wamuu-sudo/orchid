# Orchid Linux 

Orchid est une variante moderne et soignée de Gentoo, pour les ordinateurs de bureau et ordinateurs portables.

![Orchid Logo](img/ORCHID_LOGO.png)

Version actuelle du projet : Alpha 1.0.1

Il est fortement recommandé de rejoindre le Discord afin d'être tenu informé des mises à jour, et d'une documentation plus poussée qu'ici : [Orchid Linux](https://discord.gg/DeRhvP7M)

L'idée derrière ce projet est de fournir un système Gentoo utilisable graphiquement, avec des outils modernes et un look sympa, tout cela avec une installation rapide.

Pour rappel, Gentoo n'est pas conseillée si vous êtes débutant sous Linux, néanmoins, son utilisation est très pédagogique.

Attention, même si le projet est déployable et utilisable couramment, des problèmes peuvent survenir.

De nouvelles éditions sont disponibles :

- DWM et DWM Gaming.
- Gnome light et Gnome full.
- KDE Plasma.

Les éditions gaming embarquent directement l'ensemble des librairies 32bits, le support de vulkan, Wine, et bien d'autres.

Le guide d'installation est déjà disponible [ici](https://github.com/juliiine/orchid/blob/main/Installation.md).

Caractéristiques principales d'Orchid :

- Nous ne nous définissons pas comme un système d'exploitation à part entière, mais comme un "enrobage" de Gentoo. 
- Nous visons malgré tout les utilisateurs avancés, même si l'installation est moins fastidieuse.
- Il n'y a pour l'instant aucun script ou installateur graphique, c'est une installation en CLI (qui reste plus rapide et simple que celle de Gentoo).
- Tous les paquets de Gentoo sont disponibles.
- Nous utilisons le noyau gentoo-kernel-bin, qui suit le canal stable LTS officiel de Linux. Un déblocage facilité est possible.
- `eix` est installé par défaut.
- L'environnement complet `orchid-dwm` avec X11 est installé par défaut, avec un large support de cartes graphique (sauf Optimus). Firefox en binaire est aussi installé par défaut. Gnome et KDE Plasma sont aussi disponibles.
- Seulement des installations intégrant OpenRC sont disponibles, bien que SystemD soit utilisable sur Gentoo. 
- Nous avons fait le choix d'intégrer Flatpak par défaut pour des raisons de praticité. Il est également utilisé pour les outils Gaming dans les éditions respectives.


Les différentes archives sont disponibles au travers des liens fournis dans le guide d'installation.

## Contributeurs

- [Wamuu](https://github.com/wamuu-sudo) : Créateur du projet.
- Vinceff : Documentation et mise en projet, directeur de la communication.
- [Chevek](https://github.com/chevek) : Outils Gaming et optimisation.
- [Babilinx](https://github.com/babilinx) : Optimisation du projet.
- Piaf_Jaune : Responsable look.
- Kirik : Vérification de la documentation.
- L'ensemble des membres du serveur [Discord Gaming Linux FR](https://discord.gg/KAzznM4Fnb).
