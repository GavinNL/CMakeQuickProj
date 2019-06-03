# CMake Quick Project

Clone this Repository to your `$HOME/Templates` folder to easily create
start up projects from your Linux GUI.


## How It Works

Once you have cloned this repo to your `$HOME/Templates` folder, you can then
select one of the scripts to initialize your C++ Project.

Eg: Initialize an empty folder with one of the start up scripts.

Current Folder:
```Bash
/home/user/MyProject
└── library_with_unit_tests.sh
```

Execute the script in the folder.
```Bash
./library_with_unit_tests.sh
```

This will generate the following files for you to use.

```Bash
/home/user/MyProject
├── CMakeLists.txt
├── include
│   └── mylib
│       └── header.h
├── main.cpp
├── src
│   └── myfile.cpp
└── test
    ├── catch.hpp
    ├── CMakeLists.txt
    ├── main.cpp
    └── unit-main.cpp
```

## Unit Tests

Unit tests are stored in the `test` folder. If this folder doesn't exist, the  
main CMakeLists.txt file will not include any unit tests. You can always add
unit tests to your project later by using the `unit-tests.sh` script.

Any files with the pattern `unit-XXX.cpp` will be compiled into an executable and
set as a test.

Unit tests are done using the Catch2 framework. The header file is automatically
downloaded for you.

## Modules

Application projects which build executables look for an optional `modules` folder.

The modules folder is meant for external libraries that are independently compiled and tested.

If this module folder exists, any folders within it will be added as a subdirectory.

## Scripts

## Basic Projects

Basic projects are in the root folder and simply set up a pure C++ project
with CMake. No external libraries are used

### hello_world.sh

Builds a simple hello world executable. The script needs to be in an empty folder
for it to execute. The unit-test.sh script can be executed in the root source
folder to create unit tests.

### library.sh

Initializes a C++ Library project. A unit test folder can be added later using the `unit-test.sh` script. This script requires an empty folder to run.

### library_with_unit_tests.sh

Initializes a C++ Library project with a unit tests folder. This script requires an empty folder to run

### unit-test.sh

Generates a `test` folder with unit tests. This script does not require an empty folder, but the `test` directory must not already exist.

## Projects with External Libraries

More to come soon.

### GUI/qt_conan.sh

Initializes a Qt project using Qt 5.9 (The version currently available on Ubuntu 18.04).
The project uses the Conan Package Manager for the Qt Dependency
