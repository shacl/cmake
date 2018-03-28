include(LinkOptions/StackSize)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_stack_size.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_stack_size.f90.in
)

add_executable(use_stack_size ${CMAKE_CURRENT_BINARY_DIR}/use_stack_size.f90)
set_target_properties(use_stack_size PROPERTIES LINK_STACK_SIZE 1024)
target_link_libraries(use_stack_size PRIVATE LinkOptions::StackSize)

add_custom_target(run_use_stack_size ALL
  COMMAND use_stack_size
)
add_dependencies(run_use_stack_size use_stack_size)

if( WIN32 AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32)
  add_test(NAME run_use_stack_size
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_stack_size
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
