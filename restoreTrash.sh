#!/bin/bash
filename=$1
if [ $# -eq 0 ];
then 
	echo "Uasge:restorefile file1..."
	exit 1
fi
originalPath=$(awk /$filename/'{print $4}' ~/trash/.log) # filename is $1

filenameNow=$(awk  /$filename/'{print $1}' ~/trash/.log)
filenamebefore=$(awk /$filename/'{print $2}' ~/trash/.log)
echo "you are about ro restore $filenameNow,original name is $filenamebefore"
echo "original path is $originalPath"

echo "Are you sure to do that?[Y/N]"
read reply
if [ $reply = "y" -o $reply = "Y" ]
then
$(mv -b "$HOME/trash/$filenameNow" "$originalPath")
$(sed -i /$filename/'d' "$HOME/trash/.log")
else
	echo "no files restored"

	fi



arrayA=($(find ~/trash/* -mtime +7 | awk '{print $1}'))
	for file in ${arrayA[@]}
	do
		$(rm -rf "${file}")
		filename="${file##*/}"
		echo $filename
		$(sed -i /$filename/'d' "HOME/trash/.log")
		done

