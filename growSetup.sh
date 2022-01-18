#!/bin/bash

mkdir -p $HOME/work
APP="$HOME/work/grow-app"
AUTH="$HOME/work/grow-auth"
CONFIG="$HOME/work/grow-config"
CORE="$HOME/work/core"
GJP="$HOME/work/grow-job-processor"

git clone git@github.com:Growmies/grow-app.git $APP
git clone git@github.com:Growmies/grow-auth.git $AUTH
git clone git@github.com:Growmies/grow-config.git $CONFIG
git clone git@github.com:Growmies/core.git $CORE
git clone git@github.com:Growmies/grow-job-processor.git $GJP


##################################################
################ Setup Node ######################
##################################################
echo "Enter your Grow NPM Token (npm.js -> profile pic -> Access Tokens -> Generate New): "
read NPM_TOKEN
echo export GROW_NPM_TOKEN=$NPM_TOKEN >> ~/.zshrc && source ~/.zshrc
echo "Logging into NPM.  Get your password handy."
npm login --scope=@grow
npm -g install yarn gulp
yarn config set registry https://registry.npmjs.org


##################################################
################ Setup app #######################
##################################################

echo "Setup core"
fnm use $CORE/.nvmrc
yarn --cwd $CORE install
yarn --cwd $CORE link

echo "Setup config"
fnm use $CONFIG/.nvmrc
yarn --cwd $CONFIG install
# yarn --cwd $CONFIG link

echo "Setup app"
fnm use $APP/.nvmrc
yarn --cwd $APP install
# yarn --cwd $APP link @grow/core
cp $APP/docker-compose.yml.sample $APP/docker-compose.yml
cp $APP/src/server/ssl/local.gogrow.com.crt /etc/ssl/certs/
cp $APP/src/server/ssl/local.gogrow.com.key /etc/ssl/private/

echo "Setup job-processor"
fnm use $GJP/.nvmrc
yarn --cwd $GJP install
# yarn --cwd $GJP link @grow/core

echo "Setup grow-aut5h"
fnm use $AUTH/.nvmrc
yarn --cwd $AUTH install
cp $AUTH/.env.sample $AUTH/.env



aws configure
echo 'export PATH="/usr/local/opt/awscli@1/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
aws s3 cp s3://grow-files/nginx-local/nginx.conf /etc/nginx/
aws s3 cp s3://grow-files/nginx-local/local.grow.com.conf /etc/nginx/servers/
sed -i "" "s/$USER/jimmy/g" /etc/nginx/servers/local.grow.com.conf
echo "Test to make sure your nginx conf is good.  If this isn't successful, figure it out"
sudo nginx -t
sudo nginx -s reload


#Hosts File
echo "127.0.0.1    localhost" >> /etc/hosts
echo "255.255.255.255 broadcasthost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.0.1       local.gogrow.com" >> /etc/hosts
echo "127.0.0.1       local.admin.gogrow.com" >> /etc/hosts
echo "127.0.0.1:8080  local.admin.gogrow.com" >> /etc/hosts
echo "127.0.0.1       grow-php" >> /etc/hosts
echo "127.0.0.1       redis" >> /etc/hosts
echo "127.0.0.1       redis-auth" >> /etc/hosts
echo "127.0.0.1       redis-cache" >> /etc/hosts
echo "127.0.0.1       postgres" >> /etc/hosts
echo "127.0.0.1       rabbitmq" >> /etc/hosts
