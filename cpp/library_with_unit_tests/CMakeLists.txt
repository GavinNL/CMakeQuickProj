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
set(srcFiles "src/*" "include/*")          # all the source files for this library
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

#INSTALL(TARGETS ${libName}
#    DESTINATION lib
#)

include(GNUInstallDirs)
install(
   TARGETS
       ${libName}
   LIBRARY  DESTINATION "${CMAKE_INSTALL_LIBDIR}"
   ARCHIVE  DESTINATION "${CMAKE_INSTALL_LIBDIR}"
   RUNTIME  DESTINATION "${CMAKE_INSTALL_BINDIR}/.."
   INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )


################################################################################






# If you create any targets, add them to the following
# variable so that the unit tests link to them.
LIST(APPEND UNIT_TEST_LINK_TARGETS "${PROJECT_NAME}::${PROJECT_NAME}")


if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test" AND IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/test")
    enable_testing()
    add_subdirectory(test)
endif()
































#####################################################
## PACKAGE
#####################################################
SET(CPACK_PACKAGE_NAME          ${PROJECT_NAME})
SET(CPACK_PACKAGE_VENDOR        ${PROJECT_NAME})
SET(CPACK_PACKAGE_EXECUTABLES   ${PROJECT_NAME};${PROJECT_NAME})

SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "${PROJECT_NAME} 1.0.0")
SET(CPACK_PACKAGE_VERSION       "1.0.0")
SET(CPACK_PACKAGE_VERSION_MAJOR "1")
SET(CPACK_PACKAGE_VERSION_MINOR "0")
SET(CPACK_PACKAGE_VERSION_PATCH "0")
SET(CPACK_PACKAGE_CONTACT "me")

INCLUDE(InstallRequiredSystemLibraries)

IF(WIN32 AND NOT UNIX)
  SET(CPACK_NSIS_INSTALLED_ICON_NAME   "bin\\\\${PROJECT_NAME}.exe")
  SET(CPACK_NSIS_DISPLAY_NAME          "${CPACK_PACKAGE_INSTALL_DIRECTORY}${PROJECT_NAME}")
  SET(CPACK_NSIS_MODIFY_PATH           ON)
ENDIF(WIN32 AND NOT UNIX)


IF(WIN32)
#    INSTALL(TARGETS main
#        DESTINATION bin
#    )

        ##THIS IS CURRENTLY HARD CODED
#    INSTALL(FILES
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/Qt5Core.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/Qt5Gui.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/Qt5Widgets.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/Qt5Sql.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/Qt5Network.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/Qt5Xml.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/icudt49.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/icuin49.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/icuuc49.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/libEGL.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/libGLESv2.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/bin/D3DCompiler_43.dll"
#        DESTINATION bin
#    )

#    INSTALL(FILES
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/plugins/platforms/qminimal.dll"
#        "C:/Qt/Qt5.0.2/5.0.2/msvc2010/plugins/platforms/qwindows.dll"
#                DESTINATION bin/platforms
#        )

ENDIF(WIN32)

INCLUDE(CPack)
