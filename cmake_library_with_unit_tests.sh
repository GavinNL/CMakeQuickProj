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

mkdir -p test src include include/mylib

CATCH_HEADER_URL="https://raw.githubusercontent.com/catchorg/Catch2/master/single_include/catch2/catch.hpp"

echo 'cmake_minimum_required(VERSION 3.10)'                                  >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)'  >> CMakeLists.txt
echo 'string(REPLACE " " "_" folder_name ${folder_name})'                    >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'project(${folder_name})'                                               >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'set(LIBRARY_NAME MYLIB)'                                               >> CMakeLists.txt
echo 'add_library( ${LIBRARY_NAME} src/myfile.cpp )'                         >> CMakeLists.txt
echo 'add_library( ${LIBRARY_NAME}::${LIBRARY_NAME} ALIAS ${LIBRARY_NAME} )' >> CMakeLists.txt
echo 'target_include_directories( ${LIBRARY_NAME}'                           >> CMakeLists.txt
echo '                            PUBLIC'                                              >> CMakeLists.txt
echo '                               "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>"' >> CMakeLists.txt
echo ' )'                                                                    >> CMakeLists.txt
echo 'target_compile_features( ${LIBRARY_NAME}'                              >> CMakeLists.txt
echo '                          PUBLIC'                                      >> CMakeLists.txt
echo '                              cxx_std_17)'                             >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'target_compile_definitions( ${LIBRARY_NAME}'                           >> CMakeLists.txt
echo '                                PUBLIC'                                >> CMakeLists.txt
echo '                                TEST_DEFINE)'                          >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo '# If you create any targets, add them to the following'                >> CMakeLists.txt
echo '# variable so that the unit tests link to them.'                       >> CMakeLists.txt
echo 'set(UNIT_TEST_LINK_TARGETS "${LIBRARY_NAME}::${LIBRARY_NAME}")'        >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'enable_testing()'                                                      >> CMakeLists.txt
echo 'add_subdirectory(test)'                                                >> CMakeLists.txt
echo 'add_executable(main main.cpp)'                                         >> CMakeLists.txt
echo 'target_link_libraries(main PUBLIC ${LIBRARY_NAME}::${LIBRARY_NAME})'   >> CMakeLists.txt



echo '#ifndef HEADER_GUARD_H'           >> include/mylib/header.h
echo '#define HEADER_GUARD_H'           >> include/mylib/header.h
echo 'int func();'                      >> include/mylib/header.h
echo '#endif '                          >> include/mylib/header.h
echo ''                                 >> include/mylib/header.h


echo '#include <mylib/header.h>'        >> src/myfile.cpp
echo 'int func()'                       >> src/myfile.cpp
echo '{'                                >> src/myfile.cpp
echo ''                                 >> src/myfile.cpp
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


echo '#define CATCH_CONFIG_MAIN'        >> test/main.cpp
echo '#include "catch.hpp"'             >> test/main.cpp

wget -O test/catch.hpp ${CATCH_HEADER_URL}


echo '# Create a static library for Catch2s main so that we can reduce'                          >> test/CMakeLists.txt
echo '# compiling time. Each unit test will link to this'                                        >> test/CMakeLists.txt
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
