#FROM ruby:2.1
#FROM cloudgear/ruby:2.1

# rsync pw tcuser

FROM ubuntu

MAINTAINER UMich T&L

# bootstrap.sh
#RUN echo "US/Michigan" | sudo tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update

RUN apt-get install -y vim
RUN apt-get install -y emacs
RUN apt-get install -y curl
#RUN apt-get install -y rubygems
RUN apt-get install -y git

# install-rvm.sh
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable


RUN /usr/local/rvm/bin/rvm requirements
RUN /usr/local/rvm/bin/rvm ruby-2.2.1

RUN ls -l .

ADD ./ARTIFACTS/*z /my_application 

RUN ls -l /my_application

RUN 

# RUN /usr/local/rvm/bin/rmv wrapper <stuff>



# install-ruby.sh
#RUN bash -e source $HOME/.rvm/scripts/rvm && rvm use --default --install 2.2.1 bundler && rvm cleanup all 

# installRubyStub.sh
#!/bin/bash
# Install a StudentDashboard build on a Vagrant VM for testing.
# Is assumes that:
# there is 1 war file in the ARTIFACTS directory under the vagrant launch
# directory on the host.
# There is also a configSD script to install the configuration.
#set -x
# set -u
# set -e
# set -x

# ### Values that change from install to install.
# source /vagrant/VERSIONS.sh

# [ -d $HOME/RUN_DIR ] || mkdir $HOME/RUN_DIR
# cd $HOME/RUN_DIR
# tar -zxvf /vagrant/ARTIFACTS/*z

# bundle install

#rake server PORT=9100 DATA_DIR=$(pwd)/demo/demo01
##########



#FROM python:2.7

# COPY requirements.txt /tmp/
# WORKDIR /tmp/
# RUN pip install -r requirements.txt

# RUN mkdir -p /usr/src/app

# COPY . /usr/src/app

# WORKDIR /usr/src/app/

# RUN python manage.py collectstatic --noinput

# EXPOSE 8000

# CMD python manage.py runserver
