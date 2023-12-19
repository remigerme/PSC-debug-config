# PSC debug config

## Présentation du système
Configurer un projet C/C++ avec de nombreux fichiers et de nombreuses dépendances de compilation entre ces fichiers n'est pas trivial. Heureusement, des outils existent pour nous permettre d'automatiser ce travail là et nous concentrer sur le code une fois mis en place. 

Pour nous abstraire des problèmes de la machine de chacun (cette automatisation a malheureusement le mauvais goût d'être os-dépendante voire machine-dépendante), je propose que nous travaillons à distance depuis les ordis de salle info. En pratique, avec la mise en place suivante, c'est vraiment équivalent à travailler sur son PC en local (mais tous les PC de salle info ont la même architecture).

## Mise en place de la connexion SSH
Dans votre dossier utilisateur (`C:\Users\VotreNom\` sur Windows, `/Users/VotreNom/` sur macos ou `/home/VotreNom/` sur Linux), créez un dossier `.ssh` s'il n'existe pas déjà.

Ouvrez un terminal et placez-vous dans ce dossier. La commande `ssh-keygen -t rsa -b 4096` permet de générer une clé SSH (des questions vous seront posées, donnez-lui un nom si vous voulez, laissez la passkey vide de préférence).

Ensuite, choisissez votre machine de salle info préférée ([liste](https://wikix.polytechnique.org/Ordinateurs_des_salles_info)) et connectez-vous y en ssh `ssh prenom.nom@nom_machine.polytechnique.fr` (rentrez votre mot de passe LDAP, il ne s'affiche pas, c'est normal). Sur la machine distante, dans `.ssh` (créez le s'il n'existe pas déjà `mkdir .ssh`), créez un fichier `authorized_keys` : `nano authorized_keys`. Dedans, collez l'intégralité de votre clé publique générée précédemment (par défaut `id_rsa.pub`) puis quittez en sauvegardant (`ctrl`+`q` puis `y` puis `enter`).

De retour sur votre ordi perso, dans `.ssh`, créez un fichier `config` suivant (en remplaçant `id_rsa` par le fichier contenant votre clé privée) :
```
Host x
  HostName nom_machine.polytechnique.fr
  User prenom.nom
  # Décommentez la ligne pertinente (attention à bien aligner le nombre d'espaces)
  # IdentityFile ~/.ssh/id_rsa # pour Linux et macos
  # IdentityFile C:\Users\VotreNom\.ssh\id_rsa # pour Windows
```

Vous devriez maintenant pouvoir vous connecter à votre machine de salle info en tapant simplement `ssh x`.

## Configuration de VSCode
Sur votre ordi perso, installez l'extension `Remote - SSH`. Vous pouvez maintenant vous connecter à votre machine de salle info `Affichage > Palette de commandes...` (y a un raccourci clavier) puis cherchez `Connect to host` puis `x`.

Vous êtes désormais connecté sur votre machine de salle info. Installez les extensions suivantes :
- `C/C++`
- `Makefile Tools`
- `Git Extension Pack`

## Configuration de Github
Sur votre machine distante, dans `.ssh`, créez une nouvelle clé (même méthode que précédemment). Ajoutez la clé publique à votre compte Github (`Settings` > `SSH keys` > `Add new SSH key`) puis créez un fichier `config` :
```
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
```

Enfin, toujours sur votre machine distante, `git config --global --add user.name nom_utilisateur_github` et `git config --global --add user.email email.github@gmail.com`. C'est bon, Github est maintenant prêt à un emploi facile !

## Utilisation
Mettre les fichiers `launch.json` et `task.json` dans un dossier `.vscode` à la racine de votre projet.

TODO PRESENTER MAKEFILE

TODO MIEUX : NE PAS GITIGNORE LAUNCH ET TASK ET LES METTRE DANS LE GIT DU PSC