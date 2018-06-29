include(Warnings)

string(CONCAT C_GNU
  "-Wall\;"
  "-Wextra\;"
  "-Wpedantic\;"
  "-Wduplicated-branches\;"
  "-Wduplicated-cond")

string(CONCAT C_Clang
  "-Wall\;"
  "-Wextra\;"
  "-Wpedantic\;"
  "-Wassign-enum\;"
  "-Wbad-function-cast\;"
  "-Wkeyword-macro\;"
  "-Wnonportable-system-include-path\;"
  "-Wsometimes-uninitialized")

set(C_AppleClang "${C_Clang}")

if(WIN32)
  set(C_Intel "/W3")
else()
  set(C_Intel "-w3")
endif()

add_executable(warnings.c.test "")
target_link_libraries(warnings.c.test PUBLIC shacl::warnings_C)

file(GENERATE
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/warnings.c
  INPUT ${CMAKE_CURRENT_LIST_DIR}/warnings.c.in)

target_sources(warnings.c.test PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/warnings.c)

add_test(NAME warnings.c.test COMMAND warnings.c.test)
set_tests_properties(warnings.c.test PROPERTIES
  PASS_REGULAR_EXPRESSION "^${C_${CMAKE_C_COMPILER_ID}}\n$")

string(CONCAT CXX_GNU
  "-Wold-style-cast\;"
  "-Wsiggest-override\;"
  "${C_GNU}")

string(CONCAT CXX_Clang
  "-Wold-style-cast\;"
  "-Wnon-virtual-dtor\;"
  "-Wrange-loop-analysis\;"
  "-Wredundant-move\;"
  "${C_Clang}")

set(CXX_AppleClang "${CXX_Clang}")

set(CXX_Intel "${C_INTEL}")

add_executable(warnings.cpp.test "")
target_link_libraries(warnings.cpp.test PUBLIC shacl::warnings_CXX)

file(GENERATE
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/warnings.cpp
  INPUT ${CMAKE_CURRENT_LIST_DIR}/warnings.cpp.in)

target_sources(warnings.cpp.test PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/warnings.cpp)

add_test(NAME warnings.cpp.test COMMAND warnings.cpp.test)
set_tests_properties(warnings.cpp.test PROPERTIES
  PASS_REGULAR_EXPRESSION "^${CXX_${CMAKE_CXX_COMPILER_ID}}\n$")

string(CONCAT Fortran_GNU
  "-Wall\;"
  "-Wextra\;"
  "-Wpedantic\;"
  "-Wcharacter-truncation\;"
  "-Wrealloc-lhs\;"
  "-Wsurprising\;"
  "-Wuse-without-only")

set(Fortran_Intel "${C_INTEL}")

add_executable(warnings.fortran.test "")
target_link_libraries(warnings.fortran.test PUBLIC shacl::warnings_Fortran)

file(GENERATE
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/warnings.f90
  INPUT ${CMAKE_CURRENT_LIST_DIR}/warnings.f90.in)

target_sources(warnings.fortran.test PUBLIC
  ${CMAKE_CURRENT_BINARY_DIR}/warnings.f90)

add_test(NAME warnings.fortran.test COMMAND warnings.fortran.test)
set_tests_properties(warnings.fortran.test PROPERTIES
  PASS_REGULAR_EXPRESSION "^${Fortran_${CMAKE_Fortran_COMPILER_ID}}\n$")
