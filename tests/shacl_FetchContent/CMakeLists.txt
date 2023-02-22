include(CTest)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../..)

include(shacl_FetchContent)

# test override of GIT_TAG via optional cache variable
set(shacl_FetchContent.Catch2.tag.override 87074da73ecb1c2e7c35fd14f50ca21c4c002adc CACHE STRING
  "The branch/tag for package Catch2 that should be fetched instead of what is specified on the GIT_TAG line.  This still abides by the FETCHCONTENT_UPDATES_DISCONNECTED_Catch2 and FETCHCONTENT_UPDATES_DISCONNECTED variables.")
include(dependencies.cmake)

# calls to find_package will use the libraries found in dependencies.cmake via FETCHCONTENT
find_package(Catch2 2.0 REQUIRED)
find_package(shacl-trait REQUIRED)

# Second inclusion does nothing and should not print anything extra
include(dependencies.cmake)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/bar.cpp
"#include <cassert>

# Test that find_package set the ${name}_FOUND variables to TRUE
 int main(){
   assert(\"${Catch2_FOUND}\" == \"1\" );
   assert(\"${shacl-trait_FOUND}\" == \"1\" );
 }
")

add_executable(Git.FetchContent.test ${CMAKE_CURRENT_BINARY_DIR}/bar.cpp)

add_test(
  NAME shacl.cmake.Git.FetchContent.test
  COMMAND Git.FetchContent.test)
