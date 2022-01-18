#!/bin/bash
echo "This will work best if you have ALL your passwords/secrets ready to go & are connected to the VPN.  Do you want to continue? [ y/n ]"
read CONTINUE
if [[ $CONTINUE != "y" ]]
then
    exit 1
fi

APP="$HOME/work/grow-app"
AUTH="$HOME/work/grow-auth"
CONFIG="$HOME/work/grow-config"
CORE="$HOME/work/core"
GJP="$HOME/work/grow-job-processor"

echo "Creating growvars file & sourcing from .zshrc"
touch $HOME/.growvars
echo "source $CONFIG_FILES_PATH/growvars" >> $HOME/.zshrc

echo "creating work path and cloning grow repos"
mkdir -p $HOME/work

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
echo export GROW_NPM_TOKEN=$NPM_TOKEN >> $HOME/.growvars && source $HOME/.zshrc
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
echo 'export PATH="/usr/local/opt/awscli@1/bin:$PATH"' >> $HOME/.zshrc && source $HOME/.zshrc
aws s3 cp s3://grow-files/nginx-local/nginx.conf /etc/nginx/
aws s3 cp s3://grow-files/nginx-local/local.grow.com.conf /etc/nginx/servers/
sed -i "" "s/ADDYOURUSERNAME/<YOURHOMEDIRECTORY>/g" /usr/local/etc/nginx/servers/local.grow.com.conf
echo "Test to make sure your nginx conf is good.  If this isn't successful, figure it out in the grow-app README.md"
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

#growvars
echo "Your Dev DB_USER:"
read DEV_DB_USER
echo "Your Dev DB_PASSWORD:"
read DEV_DB_PASS
echo "Your Staging DB_USER:"
read STAGING_DB_USER
echo "Your Staging DB_PASSWORD:"
read STAGING_DB_PASS
echo "Your Prod DB_USER:"
read PROD_DB_USER
echo "Your Prod DB_PASSWORD:"
read PROD_DB_PASS
echo "New Relic License Key (Ask a dev for this):"
read NEW_RELIC_KEY
echo "Grow cryptokey (Ask a dev for this):"
read CRYPTO_KEY

echo "export DEVELOPMENT_DB_HOST='appdb-dev.gogrow.com'" >> $HOME/.growvars
echo "export DEVELOPMENT_DB_USER='$DEV_DB_USER'" >> $HOME/.growvars
echo "export DEVELOPMENT_DB_DB='grow'" >> $HOME/.growvars
echo "export DEVELOPMENT_DB_PASSWORD='$DEV_DB_PASS'" >> $HOME/.growvars
echo "export STAGING_DB_HOST='appdb-stg.gogrow.com'" >> $HOME/.growvars
echo "export STAGING_DB_USER='$STAGING_DB_USER'" >> $HOME/.growvars
echo "export STAGING_DB_DB='grow'" >> $HOME/.growvars
echo "export STAGING_DB_PASSWORD='$STAGING_DB_PASS'" >> $HOME/.growvars
echo "export PRODUCTION_DB_HOST='appdb-prod-source.gogrow.com'" >> $HOME/.growvars
echo "export PRODUCTION_DB_USER='$PROD_DB_USER'" >> $HOME/.growvars
echo "export PRODUCTION_DB_DB='grow'" >> $HOME/.growvars
echo "export PRODUCTION_DB_PASSWORD='$PROD_DB_PASS'" >> $HOME/.growvars
echo "export REDIS_APP_CACHE_HOST_MASTER='redis-cache'" >> $HOME/.growvars
echo "export REDIS_APP_CACHE_HOST_REPLICA='redis-cache'" >> $HOME/.growvars
echo "export REDIS_APP_CACHE_PORT='6381'" >> $HOME/.growvars
echo "export REDIS_APP_CACHE_TTL='86400' # 1 day" >> $HOME/.growvars
echo "export NEW_RELIC_LICENSE_KEY='$NEW_RELIC_KEY'" >> $HOME/.growvars
echo "export COMMON_GROW_APP_CRYPTOKEY='$CRYPTO_KEY'" >> $HOME/.growvars

source $HOME/.zshrc

echo "Are you connected to the VPN? [ y/n ]"
read vpn
if [[ $vpn = "y" ]]
then
    echo "Setup local db"
    echo "migrate"
    gulp --gulpfile $APP/gulpfile.js migrate
    echo "gulp importStaticTables"
    gulp --gulpfile $APP/gulpfile.js importStaticTables
    echo "gulp importNewDataSeriesInfo"
    gulp --gulpfile $APP/gulpfile.js importNewDataSeriesInfo
    echo "gulp pullAccountData --accountId=1"
    gulp --gulpfile $APP/gulpfile.js pullAccountData --accountId=1


    echo "ALL DONE!  Start nginx and go to ~/work/grow-app and run `gulp runAll` to run the app locally!"
else
    echo "connect to the vpn and follow the grow-app README.md to get the local DB & such setup.  You're done here"
fi
