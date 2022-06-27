Utilisation de `gettext`.

----

**Ne pas prendre en compte ce qui est écrit entre les parenthèses lors des copier/coller !**

# 0. Préparation du script

Ajouter ces lignes, au début :

```
export TEXTDOMAIN=test (nom du fichier, sans l'extantion du fichier ! ex, .sh)
export TEXTDOMAINDIR=$PWD/locale (avec les dossiers langue dans locale/ ex, locale/fr ; locale/it)
```

----

# 1. Définire les zones de texte

## La manière sale

Pour chaque texte à écrire, faire :

```
echo $(gettext "Hello World!")
```

## La manière propre, et conventionelle

*faut que je retrouve*

----

# 2. Créer les fichiers associés

### Le fichier .pot

```
xgettext -c filename.sh -o filename.pot
```

**Vérifier que l'encodage soit 'UTF-8'**

## Comment traduire

### Le fichier .po

```
msginit --locale=fr (ou autres) --input=filename.pot
```

**Vérifier que l'encodage soit 'UTF-8'**

