#!/bin/bash
#################################################################
# Create the Following Folder Structure
#
# SrcFolder
# ├── CMakeLists.txt
# ├── main.cpp
# ├── include

#################################################################

if [ "$(ls | wc -l)" != "1" ]
then
 notify-send "This folder is not empty. Can only initialize a project if this script file is the only file that exists."
 exit 1
fi

mkdir -p include

echo 'cmake_minimum_required(VERSION 3.10)'                                  >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)'  >> CMakeLists.txt
echo 'string(REPLACE " " "_" folder_name ${folder_name})'                    >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'project(${folder_name})'                                               >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'add_executable(main main.cpp)'                                         >> CMakeLists.txt
echo 'target_compile_features( main'                                         >> CMakeLists.txt
echo '                          PUBLIC'                                      >> CMakeLists.txt
echo '                              cxx_std_17)'                             >> CMakeLists.txt
echo 'target_include_directories( main'                                      >> CMakeLists.txt
echo '                            PUBLIC'                                    >> CMakeLists.txt
echo '                            "${CMAKE_SOURCE_DIR}/include"'             >> CMakeLists.txt
echo ' )'                                                                    >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/modules" AND IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/modules")'      >> CMakeLists.txt
echo '  file(GLOB module_list RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/modules" "modules/*")'                          >> CMakeLists.txt
echo '  FOREACH(child ${module_list})'                                                                              >> CMakeLists.txt
echo '       IF(IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/modules/${child}")'                                       >> CMakeLists.txt
echo '         add_subdirectory("modules/${child}")'                                                                >> CMakeLists.txt
echo '       ENDIF()'                                                                                               >> CMakeLists.txt
echo '  ENDFOREACH()'                                                                                               >> CMakeLists.txt
echo 'endif()'                                                                                                      >> CMakeLists.txt
echo '' >> CMakeLists.txt
echo 'set(UNIT_TEST_LINK_TARGETS "${UNIT_TEST_LINK_TARGETS}")'               >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo ''                                                                      >> CMakeLists.txt
echo 'if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test" AND IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/test")'                             >> CMakeLists.txt
echo '    enable_testing()'                                                  >> CMakeLists.txt
echo '    add_subdirectory(test)'                                            >> CMakeLists.txt
echo 'endif()'                                                               >> CMakeLists.txt




echo '#include <iostream>'              >> main.cpp
echo 'int main(int argc, char ** argv)' >> main.cpp
echo '{'                                >> main.cpp
echo ' '                                >> main.cpp
echo ' std::cout << "Hello world\n";'   >> main.cpp
echo ' return 0;'                       >> main.cpp
echo '}'                                >> main.cpp
echo ''                                 >> main.cpp

rm "$0"
