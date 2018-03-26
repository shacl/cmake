cmake_minimum_required( VERSION 3.2.0 )
project( test_override_fortran_compiler_defaults LANGUAGES Fortran )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../..")

include(OverrideFortranCompilerDefaults)

add_executable(use_backslash use_backslash.f90)
target_link_libraries(use_backslash PUBLIC ofcd)
add_custom_target(generate_terminal_output ALL
  COMMAND use_backslash > terminal_output)

add_dependencies(generate_terminal_output use_backslash)

enable_testing()
add_test(NAME compare_terminal_output
  COMMAND ${CMAKE_COMMAND} -E compare_files
  ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
  ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output )
