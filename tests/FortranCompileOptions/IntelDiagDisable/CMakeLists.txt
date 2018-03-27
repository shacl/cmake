cmake_minimum_required( VERSION 3.2.0 )
project( test_IntelDiagDissable LANGUAGES Fortran )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

set(Fortran.Intel.DiagDisable "1138" CACHE STRING "")
include(FortranCompileOptions/IntelDiagDisable)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_intel_diag_disable.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_intel_diag_disable.f90.in
)

add_executable(use_intel_diag_disable ${CMAKE_CURRENT_BINARY_DIR}/use_intel_diag_disable.f90)
target_link_libraries(use_intel_diag_disable PRIVATE Fortran::IntelDiagDisable)

add_custom_target(generate_terminal_output ALL
  COMMAND use_intel_diag_disable
)
add_dependencies(generate_terminal_output use_intel_diag_disable)

enable_testing()

if( WIN32 )
  add_test(NAME compare_terminal_output
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_win32
  )
else()
  add_test(NAME compare_terminal_output
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output
  )
endif()

if( NOT "Intel" STREQUAL "${CMAKE_Fortran_COMPILER_ID}" )
  set_tests_properties(compare_terminal_output PROPERTIES WILL_FAIL TRUE)
endif()
