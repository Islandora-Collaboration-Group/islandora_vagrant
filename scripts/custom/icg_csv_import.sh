#!/bin/bash

# idu.sh
#
# When placed in the ../scripts/custom directory this script will is automatically invoked by
# ../scripts/custom to load the ICG CSV Import project/module from
# from https://github.com/DigitalGrinnell/icg_csv_import
#

# Changes:
# 14-Sep-2016 - Cloning from DigitalGrinnell/icg_csv_import's 'development' branch.
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
git clone -b development https://github.com/DigitalGrinnell/icg_csv_import.git
cd icg_csv_import
git config core.filemode false

# Enable the custom modules
drush -y -u 1 en icg_csv_import

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Permissions and ownership
sudo chown -R vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

# Copy some data for import use.
sudo cp "$SHARED_DIR"/shared/CompleteSample/* "$DRUPAL_HOME"/sites/default/files

# Make necessary changes for Testing (simpletest)
drush -y -u 1 en simpletest
sudo chmod 666 /usr/local/fedora/server/config/filter-drupal.xml
