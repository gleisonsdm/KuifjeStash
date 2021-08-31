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
done

cd ../kuifje-compiler/
COMPILER=$(pwd)
FILES=$(cat "${THIS}/tmp.txt" | sort)
for f in ${FILES}; do
WORLDS=$(echo "${TOPLEVEL}/${f/.kf/.csv}")
WORLDS="${WORLDS/\/StashT/}"
WORLDS="${WORLDS/KuifjeStash\//KuifjeStash\/Worlds\/}"

cabal new-run Kuifje-compiler "${TOPLEVEL}/${f}" | \
	sed '/^$/q' | sed '$ d' | \
	sed 's/        /,/g' | sed 's/   /,/g' | \
	sed 's/R (//g' | sed 's/)//g' | \
	sed 's/ % /\//g' | tail -n +3 &> ${WORLDS}
done
cd ${THIS}

if test -f "${THIS}/tmp.txt"; then
  rm "${THIS}/tmp.txt"
fi




