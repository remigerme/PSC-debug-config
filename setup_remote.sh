#!/bin/bash

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi
cd ~/.ssh

read -p "Nom de la clé (laisser vide pour 'key_psc') : " key_name
if ["$key_name" = ""]; then
    key_name="key_psc"
fi

ssh-keygen -t rsa -b 4096 -N "" -f $key_name -q
echo "Clé créée : ~/.ssh/$key_name"

content=$"
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/$key_name
"

echo "$content" >> ~/.ssh/config
echo "Fichier config modifié"

read -p "Github username : " gh_user
read -p "Github email : " gh_email
git config --global --add user.name $gh_user
git config --global --add user.email $gh_email
echo "Github configuré. Ajoutez votre clé publique sur Github :"
cat ~/.ssh/$key_name.pub
