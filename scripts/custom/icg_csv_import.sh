#!/bin/bash

# idu.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load and the ICG CSV Import project/module from
# from https://github.com/Islandora-Collaboration-Group/icg_csv_import
#

# Changes:
# 01-Apr-2016 - Switching temporarily to DigitalGrinnell/dg_csv_import
# 31-Mar-2016 - Initial merge.
#

echo "Installing the ICG CSV Import module per icg_csv_import.sh."

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Clone custom modules from GitHub
echo "Cloning ICG's CSV import module."
cd "$DRUPAL_HOME"/sites/all/modules || exit
# git clone https://github.com/Islandora-Collaboration-Group/icg_csv_import.git
git clone https://github.com/DigitalGrinnell/icg_csv_import.git
cd icg_csv_import
git config core.filemode false

# Enable the custom modules
drush -y -u 1 en icg_csv_import

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

# Make necessary changes for Testing (simpletest)
drush -y -u 1 en simpletest
sudo chmod 666 /usr/local/fedora/server/config/filter-drupal.xml