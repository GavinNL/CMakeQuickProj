cmake_minimum_required(VERSION 3.10)

get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" folder_name ${folder_name})

project(${folder_name})


#add_library( MYLIB src/myfile.cpp )
#add_library( MYLIB::MYLIB  ALIAS  MYLIB   )
#target_include_directories( MYLIB
#                            PUBLIC
#                                "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>"
#                               )
#target_compile_features( MYLIB
#                            PUBLIC
#                               cxx_std_11)
#
#target_compile_definitions( MYLIB
#                               PUBLIC
#                                  TEST_DEFINE)

# If you create any targets, add them to the following
# variable so that the unit tests link to them.
set(UNIT_TEST_LINK_TARGETS "")










#################################################################
# No need to edit anything below this
#################################################################


#################################################################
# Create the Following Folder Structure if it doesn't exist
#
# SrcFolder
# ├── CMakeLists.txt
# ├── include
# ├── src
# └── test
#     ├── catch.hpp
#     ├── main.cpp
#     └── unit-main.cpp

#################################################################
if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test/unit-main.cpp")
    file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/test/unit-main.cpp"
"
#include \"catch.hpp\"

SCENARIO( \" Scenario 1\" )
{
    REQUIRE( 1 == 1);
}

")
endif()
#################################################################



#################################################################
# Create the catch2main file if it doesn't exist
#################################################################
if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp")
file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp"
"
#define CATCH_CONFIG_MAIN
#include \"catch.hpp\"
")
endif()
#################################################################


#################################################################
# Download the Catch2 header file if it doesn't exist.
#################################################################
if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test/catch.hpp")
    FILE(DOWNLOAD "https://raw.githubusercontent.com/catchorg/Catch2/master/single_include/catch2/catch.hpp" "${CMAKE_CURRENT_SOURCE_DIR}/test/catch.hpp")
endif()
#################################################################


# Create a static library for Catch2's main so that we can reduce
# compiling time. Each unit test will link to this
add_library(catchmain STATIC ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp)
target_include_directories(catchmain PUBLIC third_party)
target_compile_features(catchmain PUBLIC cxx_std_11)

# Find all files named unit-*.cpp
file(GLOB files "test/unit-*.cpp")

enable_testing()
foreach(file ${files})

    get_filename_component(file_basename ${file} NAME_WE)
    string(REGEX REPLACE "unit-([^$]+)" "test-${folder_name}-\\1" testcase ${file_basename})

    string(REGEX REPLACE "unit-([^$]+)" "unit-\\1" exe_name ${file_basename})

    message("New File: ${file}    Test case: ${testcase}      Exe name: ${exe_name}")

    add_executable( ${exe_name}
                    ${file}
                    )
    target_compile_features( ${exe_name}
                                PUBLIC
                                   cxx_std_11)

    target_include_directories( ${exe_name} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include )
    target_link_libraries( ${exe_name} PUBLIC catchmain ${UNIT_TEST_LINK_TARGETS})
    add_test( NAME    ${testcase}
              COMMAND ${exe_name}
            )
endforeach()
