if(CMAKE_COMPILER_IS_GNUCC)

    add_library(coverage_ INTERFACE)
    add_library(coverage::coverage ALIAS coverage_)
    target_compile_options(coverage_ INTERFACE --coverage -g -O0 -fprofile-arcs -ftest-coverage)
    target_link_libraries(coverage_ INTERFACE --coverage -g -O0 -fprofile-arcs -ftest-coverage)

    set(COVERAGE_TARGET coverage::coverage)
    set(COVERAGE_INSTALL_TARGET coverage_)

    add_custom_target(coverage
        COMMAND rm -rf coverage
        COMMAND mkdir -p coverage
        COMMAND ${CMAKE_MAKE_PROGRAM} test
        COMMAND gcovr . -r ${CMAKE_SOURCE_DIR} --html-details --html -o coverage/index.html -e ${CMAKE_SOURCE_DIR}/test/third_party;
        COMMAND gcovr . -r ${CMAKE_SOURCE_DIR} --xml -o coverage/report.xml -e ${CMAKE_SOURCE_DIR}/test/third_party;
        COMMAND gcovr . -r ${CMAKE_SOURCE_DIR} -o coverage/report.txt -e ${CMAKE_SOURCE_DIR}/test/third_party;
        COMMAND cat coverage/report.txt
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}  # Need separate command for this line
    )

endif()



#
# This Cmake file creates targets for better warnings
#
# Link to the following targets:
# warning::all  - displays all warnings
# warning::error - treats warnings as errors
#

add_library(warnings_all_ INTERFACE)
add_library(warning::all ALIAS warnings_all_)
target_compile_options(warnings_all_ INTERFACE -Wall -Wextra -Wpedantic)

set(WARNING_INSTALL_TARGET warnings_all_)

add_library(warnings_error_ INTERFACE)
add_library(warning::error ALIAS warnings_error_)
target_compile_options(warnings_error_ INTERFACE -Werror)

set(WARNING_INSTALL_TARGET ${WARNING_INSTALL_TARGET} warnings_error_)

