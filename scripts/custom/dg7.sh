#!/bin/bash

# icg_hooks.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load the DigitalGrinnell/icg_hooks module from
# https://github.com/DigitalGrinnell/icg_hooks. This module provides 'hooks' for the
# ICG CSV Import module.
#

# Changes:
# 18-Sep-2016 - Initial merge.
#

echo "Installing the ICG Hooks module per icg_hooks.sh."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Clone custom modules from GitHub
echo "Cloning ICG Hooks module."
cd "$DRUPAL_HOME"/sites/all/modules || exit
git clone https://github.com/DigitalGrinnell/icg_hooks
cd icg_hooks
git config core.filemode false

# Enable the custom module
drush -y -u 1 en icg_hooks

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -R vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

