include(FortranCompileOptions)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_no_backslash_escape.F90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_no_backslash_escape.F90.in
)

add_executable(use_no_backslash_escape ${CMAKE_CURRENT_BINARY_DIR}/use_no_backslash_escape.F90)

target_link_libraries(use_no_backslash_escape PRIVATE FortranCompileOptions::NoBackslashEscape)

add_custom_target(run_use_no_backslash_escape ALL
  COMMAND use_no_backslash_escape
)
add_dependencies(run_use_no_backslash_escape use_no_backslash_escape)

add_test(NAME run_use_no_backslash_escape
  COMMAND ${CMAKE_COMMAND} -E compare_files
    ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
    ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
)
