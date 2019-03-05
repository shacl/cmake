cmake_minimum_required(VERSION 3.12.1)
project(CXX_exceptions_C_static_linkable LANGUAGES CXX C)

add_library(abi_CXX STATIC abi.cpp)

add_executable(abi abi.c)
target_link_libraries(abi PRIVATE abi_CXX)
set_target_properties(abi PROPERTIES
  LINKER_LANGUAGE C)
