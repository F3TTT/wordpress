#!/usr/bin/env bash

yum install -y httpd
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant/www /var/www
fi
