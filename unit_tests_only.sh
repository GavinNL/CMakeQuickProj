#!/bin/bash
#################################################################
# Create the Following Folder Structure if you only need to add
# Unit tests to your library.
#
# SrcFolder
# └── test
#     ├── CMakeLists.txt
#     ├── catch.hpp
#     ├── main.cpp
#     └── unit-main.cpp

#################################################################

if [ -d "test" ]
then
 notify-send "test folder already exists. Cannot create."
 exit 1
fi
mkdir -p test

CATCH_HEADER_URL="https://raw.githubusercontent.com/catchorg/Catch2/master/single_include/catch2/catch.hpp"

echo '#include "catch.hpp"'             >> test/unit-main.cpp
echo 'SCENARIO( " Scenario 1" )'        >> test/unit-main.cpp
echo '{'                                >> test/unit-main.cpp
echo ' REQUIRE( 1 == 1);'               >> test/unit-main.cpp
echo '}'                                >> test/unit-main.cpp

echo '#define CATCH_CONFIG_MAIN'        >> test/main.cpp
echo '#include "catch.hpp"'             >> test/main.cpp

wget -O test/catch.hpp ${CATCH_HEADER_URL}


echo '# Create a static library for Catch2s main so that we can reduce'                          >> test/CMakeLists.txt
echo '# compiling time. Each unit test will link to this'                                        >> test/CMakeLists.txt
echo 'cmake_minimum_required(VERSION 3.13)'                                                      >> test/CMakeLists.txt
echo 'add_library(catchmain STATIC ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp)'                        >> test/CMakeLists.txt
echo 'target_include_directories(catchmain PUBLIC third_party)'                                  >> test/CMakeLists.txt
echo 'target_compile_features(catchmain PUBLIC cxx_std_11)'                                      >> test/CMakeLists.txt
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
echo ' add_executable( ${exe_name}'                                                              >> test/CMakeLists.txt
echo ' ${file}'                                                                                  >> test/CMakeLists.txt
echo ' )'                                                                                        >> test/CMakeLists.txt
echo ' target_compile_features( ${exe_name}'                                                     >> test/CMakeLists.txt
echo ' PUBLIC'                                                                                   >> test/CMakeLists.txt
echo ' cxx_std_11)'                                                                              >> test/CMakeLists.txt
echo ''                                                                                          >> test/CMakeLists.txt
echo ' target_include_directories( ${exe_name} PUBLIC ${CMAKE_SOURCE_DIR}/include )'             >> test/CMakeLists.txt
echo ' target_link_libraries( ${exe_name} PUBLIC catchmain ${UNIT_TEST_LINK_TARGETS})'           >> test/CMakeLists.txt
echo ' add_test( NAME ${testcase}'                                                               >> test/CMakeLists.txt
echo ' COMMAND ${exe_name}'                                                                      >> test/CMakeLists.txt
echo ' )'                                                                                        >> test/CMakeLists.txt
echo 'endforeach()'                                                                              >> test/CMakeLists.txt

rm "$0"
