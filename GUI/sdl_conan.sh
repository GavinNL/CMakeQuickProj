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
echo 'project("hello_sdl")'                                                                           >> CMakeLists.txt
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
echo 'find_package(sdl2 REQUIRED)'                                                             >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'add_executable(main'                                                                           >> CMakeLists.txt
echo '                 main.cpp)'                                                                     >> CMakeLists.txt
echo ''                                                                                              >> CMakeLists.txt
echo 'target_link_libraries(main'                                                                    >> CMakeLists.txt
echo '                      sdl2::sdl2'                                                              >> CMakeLists.txt
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


echo '[requires]'                  >> conanfile.txt
echo 'sdl2/2.0.9@bincrafters/stable' >> conanfile.txt
echo ''                            >> conanfile.txt
echo '[generators]'                >> conanfile.txt
echo 'cmake_paths'                 >> conanfile.txt


echo '#include <SDL2/SDL.h>'                                                    >> main.cpp
echo ''                                                                         >> main.cpp
echo 'int main (int argc, char** argv)'                                         >> main.cpp
echo '{'                                                                        >> main.cpp
echo '    SDL_Window* window = NULL;'                                           >> main.cpp
echo '    window = SDL_CreateWindow ('                                          >> main.cpp
echo '        "My Window", SDL_WINDOWPOS_UNDEFINED,'                            >> main.cpp
echo '        SDL_WINDOWPOS_UNDEFINED,'                                         >> main.cpp
echo '        640, 480,'                                                        >> main.cpp
echo '        SDL_WINDOW_SHOWN);'                                               >> main.cpp
echo ''                                                                         >> main.cpp
echo '    // Setup renderer'                                                    >> main.cpp
echo '    SDL_Renderer* renderer = SDL_CreateRenderer( window, -1, SDL_RENDERER_ACCELERATED);' >> main.cpp
echo ''                                                                         >> main.cpp
echo '    SDL_Event event;'                                                     >> main.cpp
echo '    bool quit = false;'                                                   >> main.cpp
echo '    while(!quit)'                                                         >> main.cpp
echo '    {'                                                                    >> main.cpp
echo '        while (SDL_PollEvent(&event))'                                    >> main.cpp
echo '        {'                                                                >> main.cpp
echo '            if( event.type == SDL_QUIT ) // User pressed the x button.'   >> main.cpp
echo '            {'                                                            >> main.cpp
echo '                quit = true;'                                             >> main.cpp
echo '            }'                                                            >> main.cpp
echo '        }'                                                                >> main.cpp
echo '        SDL_SetRenderDrawColor( renderer, 255, 0, 0, 255 );'              >> main.cpp
echo '        SDL_RenderClear( renderer );'                                     >> main.cpp
echo ''                                                                         >> main.cpp
echo '        SDL_SetRenderDrawColor( renderer, 0, 0, 255, 255 );'              >> main.cpp
echo '        SDL_Rect r{50,50,50,50};'                                         >> main.cpp
echo ''                                                                         >> main.cpp
echo '        SDL_RenderFillRect( renderer, &r );'                              >> main.cpp
echo '        SDL_RenderPresent(renderer);'                                     >> main.cpp
echo '        SDL_Delay( 16 );'                                                 >> main.cpp
echo '    }'                                                                    >> main.cpp
echo '    SDL_DestroyWindow(window);'                                           >> main.cpp
echo '    SDL_Quit();'                                                          >> main.cpp
echo ''                                                                         >> main.cpp
echo '    return EXIT_SUCCESS;'                                                 >> main.cpp
echo '}'                                                                        >> main.cpp


# Delete myself
rm "$0"
