#!/bin/bash

# icu.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load and configure Digital Grinnell's Islandora Common Utilities (icu)
# module from https://github.com/DigitalGrinnell/icu.
#
# Changes:
# 29-Mar-2016 - Initial merge.
#

echo "Installing the Digital Grinnell ICU module per icu.sh."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Clone custom modules from GitHub
echo "Cloning DG's icu Module."
cd "$DRUPAL_HOME"/sites/all/modules || exit
git clone https://github.com/DigitalGrinnell/icu
cd icu || exit
git config core.filemode false

# Enable the custom modules
drush -y -u 1 en icu

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

