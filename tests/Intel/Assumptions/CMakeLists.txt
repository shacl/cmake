include(Intel/Assumptions)

add_executable(assumptions.test "")
set_target_properties(assumptions.test PROPERTIES
  Intel_ENABLED_ASSUMPTIONS "old_xor;std_intent_in"
  Intel_DISABLED_ASSUMPTIONS "protect_parens;realloc_lhs")
target_link_libraries(assumptions.test PUBLIC Intel::Assumptions)

file(GENERATE
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/assumptions.f90
  INPUT ${CMAKE_CURRENT_LIST_DIR}/assumptions.f90.in)

target_sources(assumptions.test PUBLIC 
  ${CMAKE_CURRENT_BINARY_DIR}/assumptions.f90)

add_test(NAME assumptions.test COMMAND assumptions.test)

set_tests_properties(assumptions.test PROPERTIES
  PASS_REGULAR_EXPRESSION 
"old_xor
std_intent_in

protect_parens
realloc_lhs")
