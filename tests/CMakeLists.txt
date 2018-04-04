cmake_minimum_required(VERSION 3.2.0)
project(shacl_cmake LANGUAGES C CXX Fortran VERSION 1.0.0)

include(CTest)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/..)

add_subdirectory(FortranCompileOptions)
add_subdirectory(LinkOptions)

