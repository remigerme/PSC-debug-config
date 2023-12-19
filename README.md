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

## Utilisation
To debug C code in VSCode, put the provided `launch.json` and `task.json` in a `.vscode` folder located at the root of your project.