# PSC debug config

## Présentation du système
Configurer un projet C/C++ avec de nombreux fichiers et de nombreuses dépendances de compilation entre ces fichiers n'est pas trivial. Heureusement, des outils existent pour nous permettre d'automatiser ce travail là et nous concentrer sur le code une fois mis en place. 

Pour nous abstraire des problèmes de la machine de chacun (cette automatisation a malheureusement le mauvais goût d'être os-dépendante voire machine-dépendante), je propose que nous travaillons à distance depuis les ordis de salle info. En pratique, avec la mise en place suivante, c'est vraiment équivalent à travailler sur son PC en local (mais tous les PC de salle info ont la même architecture).

## Configuration de la connexion SSH
Si vous voulez, vous pouvez choisir votre machine de salle info préférée ([liste](https://wikix.polytechnique.org/Ordinateurs_des_salles_info)) - j'en ai mis une par défaut.

### Pour Linux et macos
Dans le dossier de `setup.sh` :
```
chmod +x setup.sh && ./setup.sh
```
C'est fini (sah quel plaisir les vrais OS) !

### Pour Windows
Les emmerdes commencent (pour moi).

Dans le dossier de `setup_windows.bat` :
```
.\setup_windows.bat
```

Sur la machine distante, dans `.ssh` (créez le s'il n'existe pas déjà `mkdir .ssh`), créez un fichier `authorized_keys` : `nano authorized_keys`. Dedans, collez l'intégralité de votre clé publique générée précédemment (par défaut `key_psc.pub`) puis quittez en sauvegardant (`ctrl`+`q` puis `y` puis `enter`).

*** 

Vous devriez maintenant pouvoir vous connecter à votre machine de salle info en tapant simplement `ssh x`.

## Configuration de VSCode
Sur votre ordi perso, installez l'extension `Remote - SSH`. Vous pouvez maintenant vous connecter à votre machine de salle info `Affichage > Palette de commandes...` (y a un raccourci clavier) puis cherchez `Connect to host` puis `x`.

Vous êtes désormais connecté sur votre machine de salle info. Installez les extensions suivantes :
- `C/C++`
- `Makefile Tools`
- `Git Extension Pack`

## Configuration de Github
Sur votre machine distante (dans le dossier où est `setup_remote.sh`) :
```
chmod +x setup_remote.sh && ./setup_remote.sh
```
Ajoutez la clé publique à votre compte Github (`Settings` > `SSH keys` > `Add new SSH key`, la copier-coller).

C'est bon, Github est maintenant prêt à un emploi facile !

## Utilisation
Mettre les fichiers `launch.json` et `task.json` dans un dossier `.vscode` à la racine de votre projet.

TODO PRESENTER MAKEFILE

TODO MIEUX : NE PAS GITIGNORE LAUNCH ET TASK ET LES METTRE DANS LE GIT DU PSC