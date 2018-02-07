cmake_minimum_required( VERSION 3.0.0 )
project( test_find_package LANGUAGES Fortran )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../..")

include(Backports)

find_package( OpenMP )

add_executable( hello ${CMAKE_CURRENT_LIST_DIR}/src/main.f90 )
target_link_libraries( hello PRIVATE OpenMP::OpenMP_Fortran )

