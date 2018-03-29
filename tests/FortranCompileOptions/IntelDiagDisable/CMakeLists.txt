set(Fortran.Intel.DiagDisable "1138;1138" CACHE STRING "")
include(FortranCompileOptions)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_intel_diag_disable.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_intel_diag_disable.f90.in
)

add_executable(use_intel_diag_disable ${CMAKE_CURRENT_BINARY_DIR}/use_intel_diag_disable.f90)
target_link_libraries(use_intel_diag_disable PRIVATE FortranCompileOptions::IntelDiagDisable)

add_custom_target(run_use_intel_diag_disable ALL
  COMMAND use_intel_diag_disable
)
add_dependencies(run_use_intel_diag_disable use_intel_diag_disable)

if( WIN32 )
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 NEWLINE_STYLE DOS
  )

  add_test(NAME run_use_intel_diag_disable
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_intel_diag_disable
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
