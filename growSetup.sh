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

# cd $HOME/work/grow-job-processor
# yarn link @grow/core
echo "yarn install & link grow core"
fnm use $CORE/.nvmrc
yarn --cwd $CORE install
yarn --cwd $CORE link

# echo "yarn install & link grow-config"
# fnm use $CONFIG/.nvmrc
# yarn --cwd $CONFIG install
# yarn --cwd $CONFIG link

echo "yarn install & link grow-app"
fnm use $APP/.nvmrc
yarn --cwd $APP install
yarn --cwd $APP link @grow/core

# cd $HOME/work/grow-app
# cp docker-compose.yml.sample docker-compose.yml
# yarn link @grow/core
# yarn

# cp src/server/ssl/local.gogrow.com.crt /etc/ssl/certs/
# cp src/server/ssl/local.gogrow.com.key /etc/ssl/private/


# aws configure
# echo 'export PATH="/usr/local/opt/awscli@1/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
# aws s3 cp s3://grow-files/nginx-local/nginx.conf /etc/nginx/
# aws s3 cp s3://grow-files/nginx-local/local.grow.com.conf /etc/nginx/servers/
# sed -i "" "s/ADDYOURUSERNAME/jimmy/g" /etc/nginx/servers/local.grow.com.conf
