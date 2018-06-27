include(CTest)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../../..)

include(git/submodule/packages)

find_package(Catch2)
find_package(fmt)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/bar.cpp
"#include <cassert>

 int main(){
   assert(\"${fmt.submodule.hash}\" == \"2e95823ef74e0dd55ae64f8c446c476bc03ea2e2\" );
   assert(\"${Catch2.submodule.branch}\" == \"master\" );
 }")

add_executable(git.submodule.packages.test ${CMAKE_CURRENT_BINARY_DIR}/bar.cpp)

add_test(
  NAME git.submodule.packages.test
  COMMAND git.submodule.packages.test)
