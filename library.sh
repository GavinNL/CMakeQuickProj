#!/bin/bash
#################################################################
# Create the Following Folder Structure
#
# SrcFolder
# ├── CMakeLists.txt
# ├── main.cpp
# ├── include
#     └── mylib
#         └── header.h
# ├── src
# └── test
#     ├── CMakeLists.txt
#     ├── catch.hpp
#     ├── main.cpp
#     └── unit-main.cpp

#################################################################

if [ "$(ls | wc -l)" != "1" ]
then
 notify-send "This folder is not empty. Can only initialize a project if this script file is the only file that exists."
 exit 1
fi

mkdir -p src include include/mylib

CATCH_HEADER_URL="https://raw.githubusercontent.com/catchorg/Catch2/master/single_include/catch2/catch.hpp"

echo 'cmake_minimum_required(VERSION 3.10)'                                  >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)'  >> CMakeLists.txt
echo 'string(REPLACE " " "_" folder_name ${folder_name})'                    >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'project(${folder_name})'                                               >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'add_library( ${PROJECT_NAME} src/myfile.cpp )'                         >> CMakeLists.txt
echo 'add_library( ${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME} )' >> CMakeLists.txt
echo 'target_include_directories( ${PROJECT_NAME}'                           >> CMakeLists.txt
echo '                            PUBLIC'                                              >> CMakeLists.txt
echo '                               "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"' >> CMakeLists.txt
echo ' )'                                                                    >> CMakeLists.txt
echo 'target_compile_features( ${PROJECT_NAME}'                              >> CMakeLists.txt
echo '                          PUBLIC'                                      >> CMakeLists.txt
echo '                              cxx_std_17)'                             >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'target_compile_definitions( ${PROJECT_NAME}'                           >> CMakeLists.txt
echo '                                PUBLIC'                                >> CMakeLists.txt
echo '                                TEST_DEFINE)'                          >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo '# If you create any targets, add them to the following'                >> CMakeLists.txt
echo '# variable so that the unit tests link to them.'                       >> CMakeLists.txt
echo 'LIST(APPEND UNIT_TEST_LINK_TARGETS "${PROJECT_NAME}::${PROJECT_NAME}")'        >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test" AND IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/test")'                             >> CMakeLists.txt
echo '    enable_testing()'                                                  >> CMakeLists.txt
echo '    add_subdirectory(test)'                                            >> CMakeLists.txt
echo 'endif()'                                                               >> CMakeLists.txt


echo '#ifndef HEADER_GUARD_H'           >> include/mylib/header.h
echo '#define HEADER_GUARD_H'           >> include/mylib/header.h
echo 'int func();'                      >> include/mylib/header.h
echo '#endif '                          >> include/mylib/header.h
echo ''                                 >> include/mylib/header.h


echo '#include <mylib/header.h>'        >> src/myfile.cpp
echo 'int func()'                       >> src/myfile.cpp
echo '{'                                >> src/myfile.cpp
echo ' return 42;'                      >> src/myfile.cpp
echo '}'                                >> src/myfile.cpp
echo ''                                 >> src/myfile.cpp


rm "$0"
