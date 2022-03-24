# Orchid Linux 

Orchid est une variante moderne et soignée de Gentoo, pour les ordinateurs de bureau et ordinateurs portables.

![Orchid Logo](img/ORCHID_LOGO.png)

Version actuelle du projet : Alpha 1.0.1

Il est fortement recommandé de rejoindre le Discord afin d'être tenu informé des mises à jour, et d'une documentation plus poussée qu'ici : [Orchid Linux](https://discord.gg/DeRhvP7M)

L'idée derrière ce projet est de fournir un système Gentoo utilisable graphiquement, avec des outils modernes, et un look sympa.

Pour rappel, Gentoo n'est pas conseillée si vous êtes débutant sous Linux, néanmoins, son utilisation est très pédagogique.

Attention, le projet est encore en phase de tests. Il n'est pas recommandé en production.

De nouvelles éditions sont disponibles, dont Gnome et KDE !

Le guide d'installation est déjà disponible [ici](https://github.com/juliiine/orchid/blob/main/Installation.md).

Caractéristiques principales d'Orchid :

- Nous ne nous définissons pas comme un système d'exploitation à part entière, mais comme un "enrobage" de Gentoo. 
- Dispose d'une version Gaming icluant de nombreux outils essentiels.
- Nous visons malgré tout les utilisateurs avancés, même si l'installation est moins fastidieuse.
- Notre miroir (basiquement un miroir Gentoo complet) est utilisé par défaut, pour ne pas encombrer les miroirs officiels.
- Il n'y a pour l'instant aucun script ou installateur graphique, c'est une installation en CLI (qui reste plus rapide et simple que celle de Gentoo).
- Tous les paquets de Gentoo sont disponibles.
- Nous utilisons le noyau gentoo-kernel-bin, qui suit le canal stable LTS officiel de Linux.
- `eix` est installé par défaut.
- L'environnement complet `orchid-dwm` avec X11 est installé par défaut, avec un large support de cartes graphique (sauf Optimus). Firefox en binaire est aussi installé par défaut. Gnome et KDE Plasma sont aussi disponibles.
- Pas de version Systemd. Nous préférons OpenRC et Flatpak. 
- Flatpak est à privilégier, car il fonctionne souvent mieux que les overlays pour certaines applications.


L'archive est disponible au travers du lien fourni dans le guide d'installation.

## Contributeurs

- Wamuu : Créateur du projet.
- Kirik : Vérification de la documentation.
- Chevek : Vérification de la documentation, et outils Gaming.
- Vinceff : Documentation et mise en projet, directeur de la communication.
- L'ensemble des membres du serveur Discord Gaming Linux FR.
