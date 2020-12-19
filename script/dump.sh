#!/bin/bash

dir=/var/apps/backup
filename="$dir/racuni-$(date +%Y-%m-%d-%H-%M).bkp.gz"
echo "$(date) backing up racuni to $filename"
mysqldump -u root --password=Dsalkjm! racuni | gzip >$filename
find $dir -type f -mtime +7 -exec rm {} \;
