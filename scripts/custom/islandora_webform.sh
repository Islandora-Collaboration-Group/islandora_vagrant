#!/bin/bash

# idu.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load and the ICG's Islandora Webform module from
# from https://github.com/commonmedia/islandora_webform
#

# Changes:
# 01-Apr-2016 - Initial merge.
#

echo "Installing the ICG's Islandora Webform from Common Media per islandora_webform.sh."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Clone custom modules from GitHub
echo "Cloning ICG's Islandora Webform module."
cd "$DRUPAL_HOME"/sites/all/modules || exit
git clone https://github.com/commonmedia/islandora_webform.git
cd islandora_webform
git config core.filemode false

# Enable the custom modules
drush -y -u 1 en islandora_webform

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

