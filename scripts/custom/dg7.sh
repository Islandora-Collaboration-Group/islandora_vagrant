#!/bin/bash

# dg7.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load and configure Digital Grinnell's dg7 module from
# https://github.com/DigitalGrinnell/dg7. This module provides 'hooks' for the
# ICG CSV Import module.
#

# Changes:
# 16-Sep-2016 - Initial merge.
#

echo "Installing the Digital Grinnell dg7 module per dg7.sh."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Make sure dependencies for ssh2 file transfer are present.
sudo apt-get -y install libssh2-1-dev libssh2-php

# Clone custom modules from GitHub
echo "Cloning DG's dg7 modules."
cd "$DRUPAL_HOME"/sites/all/modules || exit
git clone https://github.com/DigitalGrinnell/dg7
cd dg7
git config core.filemode false

# Enable the custom module
drush -y -u 1 en dg7

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

