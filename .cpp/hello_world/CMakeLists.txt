cmake_minimum_required(VERSION 3.10)

get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" folder_name ${folder_name})

################################################################################
# The Project Name will the the name of the folder. Change it if you
# dont like it.
################################################################################
project(${folder_name})
################################################################################


################################################################################
# Build the executable
#
################################################################################
set(libName              ${PROJECT_NAME})   # name of the library
set(srcFiles             "main.cpp"     )          # all the source files for this library
set(PublicLinkedTargets  ""             )
set(PrivateLinkedTargets ""             )
#-------------------------------------------------------------------------------
file(GLOB_RECURSE srcFiles ${srcFiles} )
add_executable( ${libName} ${srcFiles} )

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

################################################################################
