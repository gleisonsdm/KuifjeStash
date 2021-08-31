#!/bin/bash

THIS=$(pwd)
cd ../
TOPLEVEL=$(pwd)

createRepos() {
  if test -d "${TOPLEVEL}/PerfectRaid"; then
    rm -r "${TOPLEVEL}/PerfectRaid"
  fi
  if test -d "${TOPLEVEL}/ImperfectRaid"; then
    rm -r "${TOPLEVEL}/ImperfectRaid"
  fi
  if test -d "${TOPLEVEL}/DynImperfectRaid"; then
    rm -r "${TOPLEVEL}/DynImperfectRaid"
  fi
  mkdir "${TOPLEVEL}/PerfectRaid"
  mkdir "${TOPLEVEL}/ImperfectRaid"
  mkdir "${TOPLEVEL}/DynImperfectRaid"
}

createProgram() {
  time=$1
  directory=$2
  limit=$3
  filename="${TOPLEVEL}/${directory}/StashT_${time}.kf"
  if [ $time -gt $limit ]; then
    leaks=$limit
  else
    leaks=$time
  fi

  echo "stash := uniform [0..7];" &> ${filename}
  echo "stkout := 0;" &>> ${filename}
  echo "" &>> ${filename}


  for i in $(seq 1 "$leaks"); do
    echo "leak (stkout == stash);" &>> ${filename}
    echo "stkout := stkout + 1;" &>> ${filename}
    echo "" &>> ${filename}
  done
}

createPerfectRaid() {
  timestamp=$(seq -w 0 12)
  for t in ${timestamp}; do
    createProgram "${t}" "PerfectRaid" 8
    echo "FILE (PerfectRaid/StashT_${t}.kf) created."
  done 
}

createImperfectRaid() {
  timestamp=$(seq -w 0 12)
  for t in ${timestamp}; do
    createProgram "${t}" "ImperfectRaid" 8
    echo "FILE (ImperfectRaid/StashT_${t}.kf) created."
  done
}

createDynImperfectRaid() {
  timestamp=$(seq -w 0 12)
      
  for t in ${timestamp}; do
    number=${t#0}
    refresh=$((number%4))
    createProgram "${t}" "DynImperfectRaid" "${refresh}"
    echo "FILE (DynImperfectRaid/StashT_${t}.kf) created."
  done
}

createRepos

createPerfectRaid
createImperfectRaid
createDynImperfectRaid
