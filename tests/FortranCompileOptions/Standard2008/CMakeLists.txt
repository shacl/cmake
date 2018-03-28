include(FortranCompileOptions/Standard2008)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_standard_2008.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_standard_2008.f90.in
)

add_executable(use_standard_2008 ${CMAKE_CURRENT_BINARY_DIR}/use_standard_2008.f90)
target_link_libraries(use_standard_2008 PRIVATE FortranCompileOptions::Standard2008)

add_custom_target(run_use_standard_2008 ALL
  COMMAND use_standard_2008
)
add_dependencies(run_use_standard_2008 use_standard_2008)

if( WIN32 AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32)
  add_test(NAME run_use_standard_2008
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_standard_2008
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
