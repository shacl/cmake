include(CompileOptions/Intel)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_intel_fp_model.F90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_intel_fp_model.F90.in
)

add_executable(use_intel_fp_model ${CMAKE_CURRENT_BINARY_DIR}/use_intel_fp_model.F90)
set_target_properties(use_intel_fp_model PROPERTIES Intel_Fortran_FLOATING_POINT_MODEL "${intel.fpmodel.default}")

target_link_libraries(use_intel_fp_model PRIVATE CompileOptions::Intel::FPModel::Fortran)

add_custom_target(run_use_intel_fp_model ALL
  COMMAND use_intel_fp_model
)
add_dependencies(run_use_intel_fp_model use_intel_fp_model)

if( WIN32 )
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
                 NEWLINE_STYLE DOS
  )

  add_test(NAME run_use_intel_fp_model
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_intel_fp_model
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
