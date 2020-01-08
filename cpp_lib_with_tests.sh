#!/bin/bash
BASE_DIR=$HOME/Templates/CMakeQuickProj/

if [ "$(ls | wc -l)" != "1" ]
then
 notify-send "This folder is not empty. Can only initialize a project if this script file is the only file that exists."
 exit 1
fi

cp -r ${BASE_DIR}/.cpp/library_with_unit_tests/* .

rm cpp_lib_with_tests.sh
