#!/bin/sh
# script/travis/bundle_install.sh
 
ARCHITECTURE=`uname -m`
FILE_NAME="$BUNDLE_ARCHIVE-$ARCHITECTURE.tgz"
 
cd ~
wget -O "remote_$FILE_NAME" "ftp://$CI_FTP_URL/$FILE_NAME" && tar -xf "remote_$FILE_NAME"
wget -O "remote_$FILE_NAME.sha2" "ftp://$CI_FTP_URL/$FILE_NAME.sha2"
 
exit 0
