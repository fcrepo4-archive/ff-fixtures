#!/bin/bash

CORPUS_NAME=thread${THREAD_ID-0}
PROCESSING_DIR=govdocs

command -v curl >/dev/null || { echo "curl command not found, aborting"; exit 1; }
command -v bagit.py >/dev/null || { echo "bagit.py command not found, aborting"; exit 1; }
command -v unzip >/dev/null || { echo "unzip command not found, aborting"; exit 1; }


touch .gitignore
mkdir ${PROCESSING_DIR}

if [ -f ${PROCESSING_DIR}/processed_${CORPUS_NAME} ]; then
  echo "Already processed govdocs ${CORPUS_NAME}, aborting"
  exit 1;
fi

if [ -f ${PROCESSING_DIR}/${CORPUS_NAME}.zip ]; then
  echo " (Found existing corpus; using it)"
else
  echo " == Downloading Corpus"
  curl -o ${CORPUS_NAME}.zip http://digitalcorpora.org/corp/nps/files/govdocs1/zipfiles/${CORPUS_NAME}.zip
fi

echo " == Extracting Corpus"
unzip ${PROCESSING_DIR}/${CORPUS_NAME}.zip -d ${PROCESSING_DIR}

echo " == Bagging Corpus objects"
bagit.py --contact-name 'Digital Corpora' ${PROCESSING_DIR}/[0-9]*

echo " == Moving bagged objects"
for i in $( ls ${PROCESSING_DIR}/[0-9]* ); do
  mv $i objects
done

touch ${PROCESSING_DIR}/processed_${CORPUS_NAME}