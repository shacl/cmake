include(CompileOptions/Intel)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_intel_warn.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_intel_warn.f90.in
)

add_executable(use_intel_warn ${CMAKE_CURRENT_BINARY_DIR}/use_intel_warn.f90)
set_target_properties(use_intel_warn PROPERTIES Intel_Fortran_WARN "unused;unused")
target_link_libraries(use_intel_warn PRIVATE CompileOptions::Intel::Warn::Fortran)

add_custom_target(run_use_intel_warn ALL
  COMMAND use_intel_warn
)
add_dependencies(run_use_intel_warn use_intel_warn)

if( WIN32 )
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 NEWLINE_STYLE DOS
  )

  add_test(NAME run_use_intel_warn
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_intel_warn
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
