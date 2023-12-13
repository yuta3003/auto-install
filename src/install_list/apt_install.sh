#!/bin/bash

#=====================================================
# apt-get install at once from package list file
#=====================================================

readonly TARGET="$@"

if [ "$#" -eq 0 ]; then
  usage
fi

main() {
  for _arg in "${TARGET}"; do
    if [ -f ${_arg} ]; then
      for line in `cat ${_arg}`; do
        if [ -n "${line}" ]; then
          ret=`dpkg -l ${line} | egrep "i\s*?${line}"`
          if [ -z "${ret}" ]; then
            sudo apt-get install ${line} -y
          else
            echo "${line} is already exists."
          fi
        fi
      done
    else
      sudo apt-get install "${_arg}" -y
    fi
  done
}

usage() {
  cat <<END_OF_MESSAGE
Usage:  $0 <arg1> <arg2> <arg3> ...

 arg1  package name | package list file
 arg2  package name | package list file
 arg3  package name | package list file

END_OF_MESSAGE
  exit 1
}

main
