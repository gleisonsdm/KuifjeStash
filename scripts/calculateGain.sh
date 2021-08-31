#!/bin/bash

convertToFraction() {
  for (( i=1; i>0; i++ ));do
     check=$(echo $(echo "$1*$i" | bc | cut -d . -f 2)*1 | bc)
    if [[ $check == 0 ]];then
      fraction=$(echo -e "\e[1;34m$(echo "$1*$i" | bc | cut -d . -f 1)\e[0m/\e[1;34m$i\e[0m")
      break;
    fi
  done
}

THIS=$(pwd)

cd ../
TOPLEVEL=$(pwd)
cd "${TOPLEVEL}/Worlds"
WORLDSDIR=$(pwd)
FILES=$(find ${WORLDSDIR} -name "*.csv" | sort)

for f in ${FILES}; do
  worldProb=""
  gvuln=0.0
  while read line; do
    wProb=$(echo "${line}" | cut -d "," -f1)
    intProb=$(echo "${line}" | cut -d "," -f2)
    if [ "$wProb" != "" ]; then
      worldProb="$wProb"
      if [[ "${f}" != *"PerfectRaid"* ]]; then
        gain=$(echo "$worldProb * $intProb * 4/5" | bc -l)
      else
        gain=$(echo "$worldProb * $intProb * 1" | bc -l)
      fi
      gvuln=$(echo "$gain + $gvuln" | bc -l)
    else
      if [[ "${f}" != *"PerfectRaid"* ]]; then
        gain=$(echo "$worldProb * $intProb * 1/5" | bc -l)
      else
        gain=$(echo "$worldProb * $intProb * 0" | bc -l)
      fi
      gvuln=$(echo "$gain + $gvuln" | bc -l)
    fi
  done < "${f}"
  convertToFraction $gvuln
  echo "G-Vulnerability to ${f} is: $fraction"
done
cd ${THIS}



