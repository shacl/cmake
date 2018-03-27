set(Fortran.Intel.Warn "unused" CACHE STRING "")
include(FortranCompileOptions/IntelWarn)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_intel_warn.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_intel_warn.f90.in
)

add_executable(use_intel_warn ${CMAKE_CURRENT_BINARY_DIR}/use_intel_warn.f90)
target_link_libraries(use_intel_warn PRIVATE Fortran::IntelWarn)

add_custom_target(run_use_intel_warn ALL
  COMMAND use_intel_warn
)
add_dependencies(run_use_intel_warn use_intel_warn)

if( WIN32 )
  add_test(NAME run_use_intel_warn
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_win32
  )
else()
  add_test(NAME run_use_intel_warn
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output
  )
endif()

if(NOT "Intel" STREQUAL "${CMAKE_Fortran_COMPILER_ID}") 
  set_tests_properties(run_use_intel_warn PROPERTIES WILL_FAIL TRUE)
endif()
