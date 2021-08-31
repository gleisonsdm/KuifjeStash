#!/bin/bash

THIS=$(pwd)

cd ../
TOPLEVEL=$(pwd)

if test -f "${THIS}/tmp.txt"; then
  rm "${THIS}/tmp.txt"
fi

DIRS=$(ls -d */)
for d in ${DIRS}; do
  find ${d} -name "*.kf" >> "${THIS}/tmp.txt"
  #FLS=$(find ${d} -name "*.kf" | sort)
  #for f in ${FLS}; do
  #  echo "${f}" 
  #done
done

FILES=$(cat "${THIS}/tmp.txt" | sort -n)
for f in ${FILES}; do
  echo "${FILES}"
done

if test -f "${THIS}/tmp.txt"; then
  rm "${THIS}/tmp.txt"
fi


cd ../kuifje-compiler/
COMPILER=$(pwd)
#  cabal new-run Kuifje-compiler "${TOPLEVEL}/ImperfectStash/StashUnrollT1.kf"
cd ${THIS}
