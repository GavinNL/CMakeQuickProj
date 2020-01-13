cmake_minimum_required(VERSION 3.5)

project(painter LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Widgets REQUIRED)


################################################################################
# Build the executable
#
################################################################################
set(libName              ${PROJECT_NAME})   # name of the library
set(srcFiles             "main.cpp"     )          # all the source files for this library
set(PublicLinkedTargets  ""             )
set(PrivateLinkedTargets Qt5::Widgets   )
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





