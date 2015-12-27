#!/bin/bash 
realrm="/bin/rm"
if [ ! -d ~/trash ];
 then
	mkdir -v ~/trash
	chmod 777 ~/trash
fi
#help to create the dirctory of recycler
if [ $# -eq 0 ];
then
	echo "Uasge:delete file1[file2,file3,...]"
	echo "If the options contain -f,then teh script will exec 'rm' directly"
	exit 1
fi

while getopts "dfiPRrvW" opt
	do
		case $opt in
			f)
				exec $realrm "$@"
				;;
			*)
				#do nothing
				;;
		esac
	done
echo -ne "Are you sure you want to move the files to the trash?[Y/N]:\a"
read reply


if [ "$reply" = "y" -o "$reply" = "Y" ]
then
for file in $@
do
echo "now the shell has been to loop"
 	if [ -f "$file" -o -d "$file" ]
 	then
	echo
 	elif [ -f "$file" ]&&[ `ls -l $file|awk '{print $5}'` -gt 2147483648 ]
 	then
 	echo "$file size is larger than 2G,will be deleted directly"
 	`rm -rf $file`
 	elif [ -d "$file" ]&&[ `du -sb $file|awk '{print $1}'` -gt 2147483648 ]
 	then 
 	echo "The directory:$file is larger than 2G,will br deleted directly"
 	`rm -rf $file`
 	else
 		exit 1
 	fi
done

else
	echo "delete has been stoped"
	exit 1
fi


now=`date +%Y%m%d_%H_%M_%S`
filename="${file##*/}"
newfilename="${file##*/}_${now}"
mark1="."
mark2="/"

if [ "$file" = ${file/$mark2} ];	# / is used to transform signficant
then
	fullpath="$(pwd)/$file"
elif [ "$file" != ${file/$mark1} ];
then
	fullpath="$(pwd)/$mark1"
else
	fullpath="$file"
fi

echo "the full path of this file is :$fullpath"
mv -f $file ~/trash/$newfilename
if [ $? -eq 0 ] 
#also like if mv -f $file ~/trash/$newfilename   
#like if `mv -f $file ~/trash/$newfilename`
then
	`. ./logTrashDir.sh " $newfilename $filename $now $fullpath"`
	echo "file:$file is deleted"
else
	echo "the operation is failed"
fi
