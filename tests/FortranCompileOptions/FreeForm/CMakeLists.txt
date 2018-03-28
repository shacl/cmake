include(FortranCompileOptions/FreeForm)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_free_form.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_free_form.f90.in
)

add_executable(use_free_form ${CMAKE_CURRENT_BINARY_DIR}/use_free_form.f90)
target_link_libraries(use_free_form PRIVATE FortranCompileOptions::FreeForm)

add_custom_target(run_use_free_form ALL
  COMMAND use_free_form
)
add_dependencies(run_use_free_form use_free_form)

if( WIN32 AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32)
  add_test(NAME run_use_free_form
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_free_form
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
