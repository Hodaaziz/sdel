#! /bin/bash

find /TRASH -name "*.gz" -mtime +2 -exec rm {} \;  # finds zipped files modified two days ago and delete them

filename="$@"       # can input more than one file at a time
for i in $filename
do
if [ -e $i ]
then
echo "$filename found"
flag1=1
else
echo "$filename not found"
flag1=0
fi

if [ -f $i ]
then 
echo "$filename is a file"
flag2=1
else
echo "$filename is not a file"
flag2=0
fi
if [[ $i =~ \.gz$ ]]
then 
flag3=1
echo "zipped"
else echo "not zipped"
flag3=0
fi
if(( $flag1 == 1 && $flag2 == 1 && $flag3 == 1 ))  
then
mv $i TRASH
elif(( $flag1 == 1 && $flag2 == 1 && $flag3 == 0 ))
then
tar zcf $i.tar.gz $i 
mv $i.tar.gz TRASH
fi
done

