#!/bin/bash

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi
cd ~/.ssh

read -p "Nom de votre machine de salle info (laisser vide pour 'oncidium') : " host
if ["$host" = ""]; then
    host="oncidium"
fi

read -p "Nom de la clé (laisser vide pour 'key_psc') : " key_name
if ["$key_name" = ""]; then
    key_name="key_psc"
fi

ssh-keygen -t rsa -b 4096 -N "" -f $key_name -q
echo "Clé créée : ~/.ssh/$key_name"

read -p "Nom d'utilisateur (prenom.nom) : " username
content=$"
Host x
  HostName $host.polytechnique.fr
  User $username
  IdentityFile ~/.ssh/$key_name
"

echo "$content" >> ~/.ssh/config
echo "Fichier config modifié"

read -sp "Mot de passe LDAP X : " password
echo ""
if ! command -v sshpass &> /dev/null; then
    if [ "$(uname)" = "Darwin" ]; then
        brew install hudochenkov/sshpass/sshpass
    elif [ "$(uname)" = "Linux" ]; then
        apt-get update && apt-get upgrade && apt-get install sshpass
    else
        echo "Windows not supported yet."
    fi
fi
sshpass -p $password ssh-copy-id -i ~/.ssh/$key_name.pub -o StrictHostKeyChecking=no $username@$host.polytechnique.fr
echo "Clé ajoutée sur le serveur"

scp setup_remote.sh x:~

echo "Essayez maintenant de vous connecter en tapant 'ssh x'"
