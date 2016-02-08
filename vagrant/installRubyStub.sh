#!/bin/bash
# Install a StudentDashboard build on a Vagrant VM for testing.
# Is assumes that:
# there is 1 war file in the ARTIFACTS directory under the vagrant launch
# directory on the host.
# There is also a configSD script to install the configuration.
#set -x
set -u
set -e
set -x

### Values that change from install to install.
source /vagrant/VERSIONS.sh

[ -d $HOME/RUN_DIR ] || mkdir $HOME/RUN_DIR
cd $HOME/RUN_DIR
tar -zxvf /vagrant/ARTIFACTS/*z

bundle install

rake server PORT=9100 DATA_DIR=$(pwd)/demo/demo01
##########

