cmake_minimum_required( VERSION 3.2.0 )
project( test_use_standard_semantics LANGUAGES Fortran )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(OverrideFortranCompilerDefaults)

add_executable(use_standard_semantics use_standard_semantics.f90)
target_link_libraries(use_standard_semantics PUBLIC ofcd)

enable_testing()
add_test(NAME test_use_standard_semantics
  COMMAND ${CMAKE_COMMAND} --build . --target use_standard_semantics)
set_tests_properties(test_use_standard_semantics PROPERTIES WILL_FAIL ON)
