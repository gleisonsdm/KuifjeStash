#!/bin/bash

THIS=$(pwd)

cd ../
TOPLEVEL=$(pwd)
FILES=$(find . -name "*.kf" | sort)

if test -f "${TOPLEVEL}/output.txt"; then
  rm "${TOPLEVEL}/output.txt"
fi


cd ../kuifje-compiler/
COMPILER=$(pwd)
for f in ${FILES}; do
echo "${TOPLEVEL}/${f}"
  echo "OUTPUT to ${f}" &>> "${TOPLEVEL}/output.txt"
  cabal new-run Kuifje-compiler "${TOPLEVEL}/${f}" &>> "${TOPLEVEL}/output.txt"
done
cd ${THIS}
