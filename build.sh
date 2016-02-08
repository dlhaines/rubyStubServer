#!/usr/bin/env bash
PROJECT=rubyStubServer
SRC_URL=git@github-dlh:dlhaines/${PROJECT}.git
BRANCH=VAGRANT
TMP_BUILD=$HOME/build.tmp
ARTIFACTS_DIR=$(PWD)/ARTIFACTS

set -x
set -e
(
    echo "TMP_BUILD: [$TMP_BUILD]"
     [ -d $TMP_BUILD ] && rm -rf $TMP_BUILD
    mkdir $TMP_BUILD
    
    cd $TMP_BUILD
    git clone $SRC_URL
    cd $PROJECT
    git checkout $BRANCH
    pwd
    [ -d $ARTIFACTS_DIR ] && rm -rf $ARTIFACTS_DIR
    mkdir $ARTIFACTS_DIR
    git archive --format=tar.gz $BRANCH >| $ARTIFACTS_DIR/build.${PROJECT}.${BRANCH}.tgz
    rm -rf $TMP_BUILD
)

#git archive --format=tar.gz VAGRANT >| tmp.tgz

#end
