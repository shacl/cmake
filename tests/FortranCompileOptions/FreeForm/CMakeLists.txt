cmake_minimum_required( VERSION 3.2.0 )
project( test_FreeForm LANGUAGES Fortran )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(FortranCompileOptions/FreeForm)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_free_form.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_free_form.f90.in
)

add_executable(use_free_form ${CMAKE_CURRENT_BINARY_DIR}/use_free_form.f90)
target_link_libraries(use_free_form PRIVATE Fortran::FreeForm)

add_custom_target(generate_terminal_output ALL
  COMMAND use_free_form
)
add_dependencies(generate_terminal_output use_free_form)

enable_testing()

if( WIN32 AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32)
  add_test(NAME compare_terminal_output
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME compare_terminal_output
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
