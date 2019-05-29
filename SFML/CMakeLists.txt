cmake_minimum_required(VERSION 3.10)

get_filename_component(folder_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" folder_name ${folder_name})

project(${folder_name})

################################################################################
# If an empty directory, it will run the generator script below
################################################################################
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")

    find_package(SFML 2 REQUIRED network audio graphics window system)
    #find_package(SFML REQUIRED)

    add_executable( ${PROJECT_NAME} main.cpp )

    target_include_directories( ${PROJECT_NAME}
                                PUBLIC
                                    "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>"
                                    ${SDL2_INCLUDE_DIRS}
                                   )

    target_link_libraries( ${PROJECT_NAME} ${SDL2_LIBRARIES})

    target_compile_features( ${PROJECT_NAME}
                                PUBLIC
                                   cxx_std_11)

    target_compile_definitions( ${PROJECT_NAME}
                                   PUBLIC
                                      TEST_DEFINE)

    # If you create any targets, add them to the following
    # variable so that the unit tests link to them.
    set(UNIT_TEST_LINK_TARGETS "")

endif()


if( EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test")
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
endif()


#################################################################
# No need to edit anything below this
#################################################################

if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")
    file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp"
"#include <SDL2/SDL.h>

int main (int argc, char** argv)
{
    SDL_Window* window = NULL;
    window = SDL_CreateWindow (
        \"Jeu de la vie\", SDL_WINDOWPOS_UNDEFINED,
        SDL_WINDOWPOS_UNDEFINED,
        640, 480,
        SDL_WINDOW_SHOWN);

    // Setup renderer
    SDL_Renderer* renderer = NULL;
    renderer =  SDL_CreateRenderer( window, -1, SDL_RENDERER_ACCELERATED);
    // Set render color to red ( background will be rendered in this color )
    SDL_SetRenderDrawColor( renderer, 255, 0, 0, 255 );
    // Clear winow
    SDL_RenderClear( renderer );
    // Creat a rect at pos ( 50, 50 ) that's 50 pixels wide and 50 pixels high.
    SDL_Rect r;
    r.x = 50;
    r.y = 50;
    r.w = 50;
    r.h = 50;

    // Set render color to blue ( rect will be rendered in this color )
    SDL_SetRenderDrawColor( renderer, 0, 0, 255, 255 );
    // Render rect
    SDL_RenderFillRect( renderer, &r );
    // Render the rect to the screen
    SDL_RenderPresent(renderer);
    // Wait for 5 sec
    SDL_Delay( 5000 );
    SDL_DestroyWindow(window);
    SDL_Quit();

    return EXIT_SUCCESS;
}
")
endif()
##########

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
