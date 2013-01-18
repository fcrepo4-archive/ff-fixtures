#!/bin/bash

OUTPUT_DIR=./objects/random
FILE_PREFIX=random_
FILE_SUFFIX=.data
INPUT_SIZES=random_sizes.data
DD_BIN=`which dd`
MD5SUM_BIN=`which md5sum`
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
	$DD_BIN if=/dev/urandom of=$PATH bs=1048576 count=${LINE}
	let COUNT=COUNT+1
done

cd objects/random
$RM_BIN  manifest-md5.txt
for FILE in *
do
	$MD5SUM_BIN $FILE >> manifest-md5.txt
done
cd ../..
