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

Installez [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) si ce n'est pas déjà fait (essayez de taper `plink` dans l'invite de commande).

Dans le dossier de `setup_windows.bat` :
```
.\setup_windows.bat
```

*** 

Vous devriez maintenant pouvoir vous connecter à votre machine de salle info en tapant simplement `ssh x`.

## Configuration de VSCode
Sur votre ordi perso, installez l'extension `Remote - SSH`. Vous pouvez maintenant vous connecter à votre machine de salle info `Affichage > Palette de commandes...` (y a un raccourci clavier) puis cherchez `Connect to host` puis `x`.

Vous êtes désormais connecté sur votre machine de salle info. Installez les extensions suivantes :
- `C/C++`
- `Makefile Tools`
- `Git Extension Pack`

## Configuration de Github
Sur votre machine distante (dans le dossier où est `setup_remote.sh` - le setup du ssh envoie le fichier sur la machine dans votre home directory) :
```
chmod +x setup_remote.sh && ./setup_remote.sh
```
Ajoutez la clé publique à votre compte Github (`Settings` > `SSH keys` > `Add new SSH key`, la copier-coller).

C'est bon, Github est maintenant prêt à un emploi facile !

## Utilisation
Mettre les fichiers `launch.json` et `task.json` dans un dossier `.vscode` à la racine de votre projet.

TODO PRESENTER MAKEFILE

TODO MIEUX : NE PAS GITIGNORE LAUNCH ET TASK ET LES METTRE DANS LE GIT DU PSC