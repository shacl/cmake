include(CTest)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../../..)

include(Git/Submodule/Packages)

set(JSON_BuildTests OFF CACHE INTERNAL "")
find_package(json REQUIRED)
find_package(Catch2)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/bar.cpp
"#include <cassert>

 int main(){
   assert(\"${git.submodule.package.json.commit_hash}\" == \"3760a38b7e37c23a944d2c4fdec9028ae5ebde3a\" );
   assert(\"${git.submodule.package.Catch2.branch}\" == \"master\" );
 }")

add_executable(Git.Submodule.Packages.test ${CMAKE_CURRENT_BINARY_DIR}/bar.cpp)

add_test(
  NAME shacl.cmake.Git.Submodule.Packages.test
  COMMAND Git.Submodule.Packages.test)
