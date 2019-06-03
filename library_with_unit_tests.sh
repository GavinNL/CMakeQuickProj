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
mkdir -p test

mkdir -p test src include include/mylib

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


echo '#include <iostream>'              >> main.cpp
echo '#include <mylib/header.h>'        >> main.cpp
echo 'int main(int argc, char ** argv)' >> main.cpp
echo '{'                                >> main.cpp
echo ' '                                >> main.cpp
echo ' return func();'                  >> main.cpp
echo '}'                                >> main.cpp
echo ''                                 >> main.cpp


echo '#include "catch.hpp"'             >> test/unit-main.cpp
echo '#include <mylib/header.h>'        >> test/unit-main.cpp
echo 'SCENARIO( " Scenario 1" )'        >> test/unit-main.cpp
echo '{'                                >> test/unit-main.cpp
echo ' REQUIRE( func() == 42);'         >> test/unit-main.cpp
echo '}'                                >> test/unit-main.cpp



wget -O test/catch.hpp ${CATCH_HEADER_URL}

echo '#define CATCH_CONFIG_MAIN'        >> test/main.cpp
echo '#include "catch.hpp"'             >> test/main.cpp


echo '# Create a static library for Catch2s main so that we can reduce'                          >> test/CMakeLists.txt
echo '# compiling time. Each unit test will link to this'                                        >> test/CMakeLists.txt
echo 'cmake_minimum_required(VERSION 3.13)'                                                      >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo 'add_library(${PROJECT_NAME}-catchmain STATIC ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)'        >> test/CMakeLists.txt
echo 'target_include_directories(${PROJECT_NAME}-catchmain PUBLIC third_party)'                  >> test/CMakeLists.txt
echo 'target_compile_features(${PROJECT_NAME}-catchmain PUBLIC cxx_std_11)'                      >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo '# Find all files named unit-*.cpp'                                                         >> test/CMakeLists.txt
echo 'file(GLOB files "unit-*.cpp")'                                                             >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo 'enable_testing()'                                                                          >> test/CMakeLists.txt
echo 'foreach(file ${files})'                                                                    >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ' get_filename_component(file_basename ${file} NAME_WE)'                                    >> test/CMakeLists.txt
echo ' string(REGEX REPLACE "unit-([^$]+)" "test-${folder_name}-\\1" testcase ${file_basename})' >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ' string(REGEX REPLACE "unit-([^$]+)" "unit-\\1" exe_name ${file_basename})'                >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ' message("New File: ${file} Test case: ${testcase} Exe name: ${exe_name}")'                >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo 'set(UNIT_EXE_NAME ${PROJECT_NAME}-${exe_name} )'                                           >> test/CMakeLists.txt
echo 'set(UNIT_TEST_NAME test-${PROJECT_NAME}-${exe_name} )'                                     >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ' add_executable( ${UNIT_EXE_NAME}'                                                         >> test/CMakeLists.txt
echo ' ${file}'                                                                                  >> test/CMakeLists.txt
echo ' )'                                                                                        >> test/CMakeLists.txt
echo ' target_compile_features( ${UNIT_EXE_NAME}'                                                >> test/CMakeLists.txt
echo ' PUBLIC'                                                                                   >> test/CMakeLists.txt
echo ' cxx_std_11)'                                                                              >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ' target_link_libraries( ${UNIT_EXE_NAME} PUBLIC ${PROJECT_NAME}-catchmain ${UNIT_TEST_LINK_TARGETS})'           >> test/CMakeLists.txt
echo ' add_test( NAME ${UNIT_TEST_NAME}'                                                               >> test/CMakeLists.txt
echo ' COMMAND ${UNIT_EXE_NAME}'                                                                      >> test/CMakeLists.txt
echo ' )'                                                                                        >> test/CMakeLists.txt
echo 'endforeach()'                                                                              >> test/CMakeLists.txt

rm "$0"
