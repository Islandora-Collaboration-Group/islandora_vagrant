#!/bin/bash

# custom.sh
#
# This script, authored by Peter MacDonald and Mark McFate on 24-March-2016, was patterned
# after https://github.com/Islandora-Labs/islandora_vagrant/blob/master/scripts/islandora_modules.sh.
# Several parts of the original script remain here (commented out) for reference.
#
# Changes:
# 24-Mar-2016 - Added Mark Jordan's islandora_scg (Sample Content Generator) module with
#   representative content.
#

echo "Installing Customizations"

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  # shellcheck source=/dev/null
  . "$SHARED_DIR"/configs/variables
fi

# Permissions and ownership
#sudo chown -hR vagrant:www-data "$DRUPAL_HOME"/sites/all/modules
#sudo chmod -R 755 "$DRUPAL_HOME"/sites/all/modules

# Clone custom modules from GitHub
echo "Cloning Mark Jordan's islandora_scg Module..."
cd "$DRUPAL_HOME"/sites/all/modules || exit
git clone https://github.com/mjordan/islandora_scg
cd islandora_scg
git config core.filemode false

# Move pdf.js drush file to user's .drush folder
#if [ -d "$HOME_DIR/.drush" ] && [ -f "$DRUPAL_HOME/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" ]; then
#  mv "$DRUPAL_HOME/sites/all/modules/islandora_pdfjs/islandora_pdfjs.drush.inc" "$HOME_DIR/.drush"
#fi

# Enable the custom modules
drush -y -u 1 en islandora_scg

cd "$DRUPAL_HOME"/sites/all/modules || exit

# Set variables for Islandora modules
#drush eval "variable_set('islandora_audio_viewers', array('name' => array('none' => 'none', 'islandora_videojs' => 'islandora_videojs'), 'default' => 'islandora_videojs'))"

# Adding in Peter's SCG drush commands to create the content...
cd /var/www/drupal/sites/all/modules/islandora_scg || exit
sudo drush iscgl --user=admin --quantity=2 --content_model=islandora:collectionCModel --parent=islandora:root --namespace=icg-collection
sudo drush iscgl --user=admin --quantity=7 --content_model=islandora:sp_basic_image --parent=islandora:sp_basic_image_collection --namespace=icg-basic-image
sudo drush iscgl --user=admin --quantity=2 --content_model=islandora:sp_large_image_cmodel --parent=islandora:sp_large_image_collection --namespace=icg-large-image
sudo drush iscgl --user=admin --quantity=7 --content_model=islandora:sp_pdf --parent=islandora:sp_pdf_collection --namespace=icg-pdf
sudo drush iscgl --user=admin --quantity=2 --content_model=islandora:bookCModel --parent=islandora:bookCollection --namespace=icg-book
sudo drush iscgl --user=admin --quantity=2 --content_model=islandora:newspaperCModel --parent=islandora:newspaper_collection --namespace=icg-newspaper2
sudo drush iscgl --user=admin --quantity=2 --content_model=islandora:newspaperPageCModel --parent=icg-newspaper2:1 --namespace=icg-newspaper-page
sudo drush iscgl --user=admin --quantity=2 --content_model=islandora:newspaperPageCModel --parent=icg-newspaper2:2 --namespace=icg-newspaper-page
