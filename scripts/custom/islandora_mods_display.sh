#!/bin/bash

# islandora_mods_display.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load and the https://github.com/jyobb/islandora_mods_display project/module.
#

# Changes:
# 20-Apr-2016 - Initial version.
#

echo "Installing the Islandora MODS Display module per islandora_mods_display.sh."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Clone custom modules from GitHub
echo "Cloning Islandora MODS Display module."
cd "$DRUPAL_HOME"/sites/all/modules || exit
git clone https://github.com/jyobb/islandora_mods_display
cd islandora_mods_display
git config core.filemode false

# Enable the custom modules
drush -y -u 1 en islandora_mods_display

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

