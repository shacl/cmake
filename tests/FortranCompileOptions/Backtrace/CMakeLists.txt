include(FortranCompileOptions)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_backtrace.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_backtrace.f90.in
)

add_executable(use_backtrace ${CMAKE_CURRENT_BINARY_DIR}/use_backtrace.f90)
target_link_libraries(use_backtrace PRIVATE FortranCompileOptions::Backtrace)

add_custom_target(run_use_backtrace ALL
  COMMAND use_backtrace
)
add_dependencies(run_use_backtrace use_backtrace)

if( WIN32 )
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32 
                 ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 NEWLINE_STYLE DOS
  )

  add_test(NAME run_use_backtrace
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_backtrace
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
