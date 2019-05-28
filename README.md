# CMake Quick Project

This CMakeLists.txt file is intended to be used for starting up a quick
C++ project for quick prototyping. It's a single file which generates some basic
C++ files and unit testing.

Copy the CMakeLists.txt file to your $HOME/Templates folder to easily creates
the file from your File Browser (Nautilus/Nemo/etc)

## Quick Start

```Bash
# create an empty folder
mkdir MyTestProj

# Download or copy the file to the empty folder
wget https://raw.githubusercontent.com/GavinNL/CMakeQuickProj/master/CMakeLists.txt

# Run Cmake to generate some initial files
mkdir build
cd build
cmake ..

# Compile the files
make

# run unit tests
ctest
```

## Basic Functionality

When you first run the `cmake` it will generate the following files for you.

Any files in the `test` folder named `unit-XXX.cpp` will be compiled into a
executable.

```
 SrcFolder
 ├── CMakeLists.txt
 └── test
     ├── catch.hpp
     ├── main.cpp
     └── unit-main.cpp
```
