cmake_minimum_required(VERSION 3.12.1)
project(CXX_exceptions_Fortran_static_linkable LANGUAGES CXX Fortran)

add_library(abi_CXX STATIC abi.cpp)

add_executable(abi abi.F90)
target_link_libraries(abi PRIVATE abi_CXX)
set_target_properties(abi PROPERTIES
  LINKER_LANGUAGE Fortran)
