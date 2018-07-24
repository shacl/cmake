include(CompileOptions/Intel)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_intel_standard_adherence.F90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_intel_standard_adherence.F90.in
)

add_executable(use_intel_standard_adherence ${CMAKE_CURRENT_BINARY_DIR}/use_intel_standard_adherence.F90)

target_link_libraries(use_intel_standard_adherence PRIVATE CompileOptions::Intel::FortranStandardAdherence)

add_custom_target(run_use_intel_standard_adherence ALL
  COMMAND use_intel_standard_adherence
)
add_dependencies(run_use_intel_standard_adherence use_intel_standard_adherence)

if( WIN32 )
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 NEWLINE_STYLE DOS
  )

  add_test(NAME run_use_intel_standard_adherence
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_intel_standard_adherence
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
