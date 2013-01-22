#!/bin/bash

#detect os
OS_NAME=`uname -s`

OUTPUT_DIR=./objects/random
FILE_PREFIX=random_
FILE_SUFFIX=.data
INPUT_SIZES=random_sizes.data
DD_BIN=`which dd`
RM_BIN=`which rm`
COUNT=1

# first create the output dir if it does not exist
if [ ! -d $OUTPUT_DIR ]; then
	mkdir $OUTPUT_DIR
fi

for LINE in $(cat $INPUT_SIZES) 
do
	PATH=${OUTPUT_DIR}/${FILE_PREFIX}${COUNT}${FILE_SUFFIX}
	echo "creating file ${PATH} of size ${LINE} MB"
	$DD_BIN if=/dev/zero of=$PATH bs=1048576 count=${LINE}
	let COUNT=COUNT+1
done

CURRENT_DIR=`pwd`
cd ${OUTPUT_DIR} 
# remove old manifest
if [ -f manifest.txt ]; then
	$RM_BIN manifest.txt
fi

#iterate over all the random files and add them to the manifest
for FILE in *${FILE_SUFFIX}
do
	echo $FILE >> manifest.txt
done
cd $CURRENT_DIR
