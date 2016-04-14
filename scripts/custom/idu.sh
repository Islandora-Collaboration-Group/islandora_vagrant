#!/bin/bash

# idu.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load and configure Digital Grinnell's Islandora Drush Utilities (idu)
# module from https://github.com/DigitalGrinnell/idu.
#
# Note that idu is dependent upon the icu (Islandora Common Utilities) module.

# Changes:
# 29-Mar-2016 - Initial merge.
#

echo "Installing the Digital Grinnell IDU module per idu.sh."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Clone custom modules from GitHub
echo "Cloning DG's idu Module."
cd "$DRUPAL_HOME"/sites/all/modules || exit
git clone https://github.com/DigitalGrinnell/idu
cd idu || exit
git config core.filemode false

# Enable the custom modules
drush -y -u 1 en idu

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

