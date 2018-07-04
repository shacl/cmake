include(Warnings)

set(C_GNU -Wall -Wextra -Wpedantic)
if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER "7.0")
  list(APPEND C_GNU -Wduplicated-branches)
endif()
if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER "6.0")
  list(APPEND C_GNU -Wduplicated-cond)
endif()

string(REPLACE ";" "\;" C_GNU "${C_GNU}")
set(C_Clang -Wall -Wextra -Wpedantic -Wassign-enum
            -Wbad-function-cast -Wkeyword-macro
            -Wnonportable-system-include-path
            -Wsometimes-uninitialized)
string(REPLACE ";" "\;" C_GNU "${C_Clang}")

set(C_AppleClang "${C_Clang}")

if(WIN32)
  set(C_Intel "/W3")
else()
  set(C_Intel "-w3")
endif()

set(C_MSVC "/W3")

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
  "-Wsuggest-override\;"
  "${C_GNU}")

string(CONCAT CXX_Clang
  "-Wold-style-cast\;"
  "-Wnon-virtual-dtor\;"
  "-Wrange-loop-analysis\;"
  "-Wredundant-move\;"
  "${C_Clang}")

set(CXX_AppleClang "${CXX_Clang}")

set(CXX_Intel "${C_Intel}")
set(CXX_MSVC "${C_MSVC}")

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

if(WIN32)
  set(Fortran_Intel "${C_INTEL}\;/warn:all")
else()
  set(Fortran_Intel "${C_INTEL}\;-warn;all")
endif()

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
