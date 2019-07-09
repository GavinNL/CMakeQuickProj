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


echo 'cmake_minimum_required(VERSION 3.10)'                                                          >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'project("hello_qt")'                                                                           >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'if(${CMAKE_BINARY_DIR}/conanfile.txt IS_NEWER_THAN ${CMAKE_BINARY_DIR}/conan_paths.cmake)'     >> CMakeLists.txt
echo '  execute_process(COMMAND'                                                                     >> CMakeLists.txt
echo '                      conan install ${CMAKE_SOURCE_DIR} --build missing -g cmake_find_package' >> CMakeLists.txt
echo '                  WORKING_DIRECTORY'                                                           >> CMakeLists.txt
echo '                      ${CMAKE_BINARY_DIR}'                                                     >> CMakeLists.txt
echo '                  )'                                                                           >> CMakeLists.txt
echo 'endif()'                                                                                       >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo '# If the conan_paths.cmake file exists, include it so that find_package(QtXXX)'                >> CMakeLists.txt
echo '# works'                                                                                       >> CMakeLists.txt
echo 'if(EXISTS ${CMAKE_BINARY_DIR}/conan_paths.cmake)'                                              >> CMakeLists.txt
echo '    include(${CMAKE_BINARY_DIR}/conan_paths.cmake)'                                            >> CMakeLists.txt
echo 'endif()'                                                                                       >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'find_package(Qt5Widgets REQUIRED)'                                                             >> CMakeLists.txt
echo 'find_package(Qt5Core    REQUIRED)'                                                             >> CMakeLists.txt
echo 'find_package(Qt5OpenGL  REQUIRED)'                                                             >> CMakeLists.txt
echo 'find_package(Qt5Network REQUIRED)'                                                             >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo '# Find includes in corresponding build directories'                                            >> CMakeLists.txt
echo 'set(CMAKE_INCLUDE_CURRENT_DIR ON)'                                                             >> CMakeLists.txt
echo '# Instruct CMake to run moc automatically when needed'                                         >> CMakeLists.txt
echo 'set(CMAKE_AUTOMOC ON)'                                                                         >> CMakeLists.txt
echo '# Create code from a list of Qt designer ui files'                                             >> CMakeLists.txt
echo 'set(CMAKE_AUTOUIC ON)'                                                                         >> CMakeLists.txt
echo '#  Auto run compiling of resource files'                                                       >> CMakeLists.txt
echo 'set(CMAKE_AUTORCC ON)'                                                                         >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'add_executable(main'                                                                           >> CMakeLists.txt
echo '                 main.cpp'                                                                     >> CMakeLists.txt
echo '                 mainwindow.cpp)'                                                              >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'target_link_libraries(main'                                                                    >> CMakeLists.txt
echo '                      Qt5::Widgets'                                                            >> CMakeLists.txt
echo '                      Qt5::Core'                                                               >> CMakeLists.txt
echo ')'                                                                                             >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'target_compile_features( main'                                                                 >> CMakeLists.txt
echo '                          PUBLIC'                                                              >> CMakeLists.txt
echo '                              cxx_std_17)'                                                     >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'target_include_directories( main'                                                              >> CMakeLists.txt
echo '                            PUBLIC'                                                            >> CMakeLists.txt
echo '                               "${CMAKE_SOURCE_DIR}/include"'                                  >> CMakeLists.txt
echo ')'                                                                                             >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo ''                                                                                                         >> CMakeLists.txt
echo 'if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/modules" AND IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/modules")'  >> CMakeLists.txt
echo '  file(GLOB module_list RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/modules" "modules/*")'                      >> CMakeLists.txt
echo '  FOREACH(child ${module_list})'                                                                          >> CMakeLists.txt
echo '       IF(IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/modules/${child}")'                                   >> CMakeLists.txt
echo '         add_subdirectory("modules/${child}")'                                                            >> CMakeLists.txt
echo '       ENDIF()'                                                                                           >> CMakeLists.txt
echo '  ENDFOREACH()'                                                                                           >> CMakeLists.txt
echo 'endif()'                                                                                                  >> CMakeLists.txt
echo ''                                                                                                         >> CMakeLists.txt
echo 'set(UNIT_TEST_LINK_TARGETS "${UNIT_TEST_LINK_TARGETS}")'                                                  >> CMakeLists.txt
echo ''                                                                                                         >> CMakeLists.txt
echo ''                                                                                                         >> CMakeLists.txt
echo 'if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test" AND IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/test")'        >> CMakeLists.txt
echo '    enable_testing()'                                                                                     >> CMakeLists.txt
echo '    add_subdirectory(test)'                                                                               >> CMakeLists.txt
echo 'endif()'                                                                                                  >> CMakeLists.txt

echo '#ifndef MAINWINDOW_H'                                                   >> mainwindow.h
echo '#define MAINWINDOW_H'                                                   >> mainwindow.h
echo ''                                                                       >> mainwindow.h
echo '#include <QMainWindow>'                                                 >> mainwindow.h
echo ''                                                                       >> mainwindow.h
echo 'namespace Ui {'                                                         >> mainwindow.h
echo 'class MainWindow;'                                                      >> mainwindow.h
echo '}'                                                                      >> mainwindow.h
echo ''                                                                       >> mainwindow.h
echo 'class MainWindow : public QMainWindow'                                  >> mainwindow.h
echo '{'                                                                      >> mainwindow.h
echo '    Q_OBJECT'                                                           >> mainwindow.h
echo ''                                                                       >> mainwindow.h
echo 'public:'                                                                >> mainwindow.h
echo '    explicit MainWindow(QWidget *parent = nullptr);'                    >> mainwindow.h
echo '    ~MainWindow();'                                                     >> mainwindow.h
echo ''                                                                       >> mainwindow.h
echo 'private:'                                                               >> mainwindow.h
echo '    Ui::MainWindow *ui;'                                                >> mainwindow.h
echo '};'                                                                     >> mainwindow.h
echo ''                                                                       >> mainwindow.h
echo '#endif // MAINWINDOW_H'                                                 >> mainwindow.h

echo '#include "mainwindow.h"'                   >> mainwindow.cpp
echo '#include "ui_mainwindow.h"'                >> mainwindow.cpp
echo ''                                          >> mainwindow.cpp
echo 'MainWindow::MainWindow(QWidget *parent) :' >> mainwindow.cpp
echo '    QMainWindow(parent),'                  >> mainwindow.cpp
echo '    ui(new Ui::MainWindow)'                >> mainwindow.cpp
echo '{'                                         >> mainwindow.cpp
echo '    ui->setupUi(this);'                    >> mainwindow.cpp
echo '}'                                         >> mainwindow.cpp
echo ''                                          >> mainwindow.cpp
echo 'MainWindow::~MainWindow()'                 >> mainwindow.cpp
echo '{'                                         >> mainwindow.cpp
echo '    delete ui;'                            >> mainwindow.cpp
echo '}'                                         >> mainwindow.cpp


echo '[requires]'                  >> conanfile.txt
echo 'qt/5.9.8@bincrafters/stable' >> conanfile.txt
echo ''                            >> conanfile.txt
echo '[generators]'                >> conanfile.txt
echo 'cmake_paths'                 >> conanfile.txt
echo 'qt'                          >> conanfile.txt


echo '#include "mainwindow.h"'                                                >> main.cpp
echo '#include <QApplication>'                                                >> main.cpp
echo '#include <cstdlib>'                                                     >> main.cpp
echo ''                                                                       >> main.cpp
echo 'int main(int argc, char *argv[])'                                       >> main.cpp
echo '{'                                                                      >> main.cpp
echo '    // Conans qt package needs to know where the fonts are stored'      >> main.cpp
echo '    setenv("QT_QPA_FONTDIR", "/usr/share/fonts/truetype", false);'      >> main.cpp
echo '    setenv("QT_XKB_CONFIG_ROOT", "/usr/share/X11/xkb", false);'         >> main.cpp
echo ''                                                                       >> main.cpp
echo '    QApplication a(argc, argv);'                                        >> main.cpp
echo '    MainWindow w;'                                                      >> main.cpp
echo '    w.show();'                                                          >> main.cpp
echo ''                                                                       >> main.cpp
echo '    return a.exec();'                                                   >> main.cpp
echo '}'                                                                      >> main.cpp




echo '<?xml version="1.0" encoding="UTF-8"?>' >> mainwindow.ui
echo '<ui version="4.0">' >> mainwindow.ui
echo ' <class>MainWindow</class>' >> mainwindow.ui
echo ' <widget class="QMainWindow" name="MainWindow">' >> mainwindow.ui
echo '  <property name="geometry">' >> mainwindow.ui
echo '   <rect>' >> mainwindow.ui
echo '    <x>0</x>' >> mainwindow.ui
echo '    <y>0</y>' >> mainwindow.ui
echo '    <width>561</width>' >> mainwindow.ui
echo '    <height>476</height>' >> mainwindow.ui
echo '   </rect>' >> mainwindow.ui
echo '  </property>' >> mainwindow.ui
echo '  <property name="windowTitle">' >> mainwindow.ui
echo '   <string>MainWindow</string>' >> mainwindow.ui
echo '  </property>' >> mainwindow.ui
echo '  <widget class="QWidget" name="centralWidget">' >> mainwindow.ui
echo '   <widget class="QPushButton" name="pushButton">' >> mainwindow.ui
echo '    <property name="geometry">' >> mainwindow.ui
echo '     <rect>' >> mainwindow.ui
echo '      <x>170</x>' >> mainwindow.ui
echo '      <y>100</y>' >> mainwindow.ui
echo '      <width>131</width>' >> mainwindow.ui
echo '      <height>51</height>' >> mainwindow.ui
echo '     </rect>' >> mainwindow.ui
echo '    </property>' >> mainwindow.ui
echo '    <property name="text">' >> mainwindow.ui
echo '     <string>PushButton</string>' >> mainwindow.ui
echo '    </property>' >> mainwindow.ui
echo '   </widget>' >> mainwindow.ui
echo '  </widget>' >> mainwindow.ui
echo '  <widget class="QMenuBar" name="menuBar">' >> mainwindow.ui
echo '   <property name="geometry">' >> mainwindow.ui
echo '    <rect>' >> mainwindow.ui
echo '     <x>0</x>' >> mainwindow.ui
echo '     <y>0</y>' >> mainwindow.ui
echo '     <width>561</width>' >> mainwindow.ui
echo '     <height>22</height>' >> mainwindow.ui
echo '    </rect>' >> mainwindow.ui
echo '   </property>' >> mainwindow.ui
echo '  </widget>' >> mainwindow.ui
echo '  <widget class="QToolBar" name="mainToolBar">' >> mainwindow.ui
echo '   <attribute name="toolBarArea">' >> mainwindow.ui
echo '    <enum>TopToolBarArea</enum>' >> mainwindow.ui
echo '   </attribute>' >> mainwindow.ui
echo '   <attribute name="toolBarBreak">' >> mainwindow.ui
echo '    <bool>false</bool>' >> mainwindow.ui
echo '   </attribute>' >> mainwindow.ui
echo '  </widget>' >> mainwindow.ui
echo '  <widget class="QStatusBar" name="statusBar"/>' >> mainwindow.ui
echo ' </widget>' >> mainwindow.ui
echo ' <layoutdefault spacing="6" margin="11"/>' >> mainwindow.ui
echo ' <resources/>' >> mainwindow.ui
echo ' <connections/>' >> mainwindow.ui
echo '</ui>' >> mainwindow.ui


# Delete myself
rm "$0"
