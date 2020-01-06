cmake_minimum_required(VERSION 3.10)

get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" folder_name ${folder_name})

################################################################################
# The Project Name will the the name of the folder. Change it if you
# dont like it.
################################################################################
project(${folder_name})
################################################################################

# Extra targets.  adds coverage::coverage, warning::all, warning:error
include(.cmake/extras.cmake)

option( ${PROJECT_NAME}_ENABLE_COVERAGE "Enable Coverage. After build, execute make coverage"        TRUE)
option( ${PROJECT_NAME}_ENABLE_WARNINGS "Enable Strict Warnings" TRUE)

################################################################################
# Build the Library.
#  By default, the library name will be the ${PROJECT_NAME}
#
#  If you wish to add more libraries, make a copy of this section and
# change the values below.
################################################################################
set(libName ${PROJECT_NAME})   # name of the library
set(srcFiles "src/*")          # all the source files for this library
set(PublicLinkedTargets  "" )
set(PrivateLinkedTargets "" )
#-------------------------------------------------------------------------------
file(GLOB_RECURSE srcFiles ${srcFiles} )
add_library( ${libName} ${srcFiles} )
add_library( ${libName}::${libName} ALIAS ${libName} )

target_include_directories( ${libName}
                            PUBLIC
                               "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
 )

target_compile_features( ${libName}
                          PUBLIC
                              cxx_std_17)

target_compile_definitions( ${libName}
                                PUBLIC
                                TEST_DEFINE)

target_link_libraries( ${libName}  PUBLIC  ${PublicLinkedTargets}  )
target_link_libraries( ${libName}  PRIVATE ${PrivateLinkedTargets} )

if( ${PROJECT_NAME}_ENABLE_COVERAGE )
    target_link_libraries( ${libName}  PRIVATE  coverage::coverage  )
endif()
if( ${PROJECT_NAME}_ENABLE_WARNINGS )
    target_link_libraries( ${libName}  PRIVATE   warning::all warning::error  )
endif()
################################################################################




# If you create any targets, add them to the following
# variable so that the unit tests link to them.
LIST(APPEND UNIT_TEST_LINK_TARGETS "${PROJECT_NAME}::${PROJECT_NAME}")


if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test" AND IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/test")
    enable_testing()
    add_subdirectory(test)
endif()
