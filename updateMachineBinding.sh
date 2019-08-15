#!/bin/bash

CURRENTDIR=`pwd`
CHNAGEDDIR=$CURRENTDIR"/tmp/"
if [ ! -d $CHNAGEDDIR ]
then
mkdir -p $CHNAGEDDIR
fi

ls -1 *.xml | while read myFile
do
if [ `grep "<isFt>true" $myFile | wc -l` -gt 0 ]
then
  echo $myFile" : already has FT settings"
else
  if [ `grep "<\/setting>" $myFile | wc -l` -lt 1 ]
  then
    echo $myFile" has one instance deployed only"
  else
  cp -p $myFile $CHNAGEDDIR/$myFile
  sed -i "s/<isFt>false<\/isFt>/<isFt>true<\/isFt><faultTolerant><hbInterval>10000<\/hbInterval><activationInterval>35000<\/activationInterval><preparationDelay>0<\/preparationDelay><\/faultTolerant>/g" $CHNAGEDDIR/$myFile
  sed -i "s/<\/setting>/<ftWeight>200<\/ftWeight><\/setting>/g" $CHNAGEDDIR/$myFile
  fi
fi
done
