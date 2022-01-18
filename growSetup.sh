#!/bin/bash

mkdir -p $HOME/work

git clone git@github.com:Growmies/core.git $HOME/work/core
git clone git@github.com:Growmies/grow-app.git $HOME/work/grow-app
git clone git@github.com:Growmies/grow-auth.git $HOME/work/grow-auth
git clone git@github.com:Growmies/grow-config.git $HOME/work/grow-config
git clone git@github.com:Growmies/grow-job-processor.git $HOME/work/grow-job-processor
git clone git@github.com:Growmies/grow-php.git $HOME/work/grow-php

# cd $HOME/work/core


##################################################
################ Setup Node ######################
##################################################
npm login --scope=@grow
npm -g install yarn gulp
yarn config set registry https://registry.npmjs.org

#Install & Link local core
# yarn
# yarn link

##################################################
################ Setup app #######################
##################################################

# cd $HOME/work/grow-job-processor
# yarn link @grow/core
# yarn

# cd $HOME/work/grow-app
# cp docker-compose.yml.sample docker-compose.yml
# yarn link @grow/core
# yarn

# cp src/server/ssl/local.gogrow.com.crt /etc/ssl/certs/
# cp src/server/ssl/local.gogrow.com.key /etc/ssl/private/


# aws configure
# aws s3 cp s3://grow-files/nginx-local/nginx.conf /etc/nginx/
# aws s3 cp s3://grow-files/nginx-local/local.grow.com.conf /etc/nginx/servers/
# sed -i "" "s/ADDYOURUSERNAME/jimmy/g" /etc/nginx/servers/local.grow.com.conf
