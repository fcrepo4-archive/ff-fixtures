#!/bin/bash

CORPUS_NAME=thread${THREAD_ID-0}
PROCESSING_DIR=govdocs
BAGIT_PY_CMD=${BAGIT_PY-./bagit.py}

command -v curl >/dev/null || { echo "curl command not found, aborting"; exit 1; }
command -v python >/dev/null || { echo "python command not found, aborting"; exit 1; }
command -v unzip >/dev/null || { echo "unzip command not found, aborting"; exit 1; }

if [ ! -f $BAGIT_PY_CMD ]; then
	echo "bagit.py command not found, aborting."
	echo "Hint: try calling this script with an explicit BAGIT_PY, e.g.:"
	echo "$ BAGIT_PY=./path/to/bagit.py $0"; exit 1;
fi

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
python $BAGIT_PY_CMD --contact-name 'Digital Corpora' ${PROCESSING_DIR}/[0-9]*

echo " == Moving bagged objects"
for i in $( ls ${PROCESSING_DIR}/[0-9]* ); do
  mv $i objects
done

touch ${PROCESSING_DIR}/processed_${CORPUS_NAME}