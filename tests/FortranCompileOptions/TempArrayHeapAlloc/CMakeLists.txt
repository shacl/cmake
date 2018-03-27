include(FortranCompileOptions/TempArrayHeapAlloc)

MakeTempArrayHeapAllocTarget(1024)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_temp_array_heap_alloc.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_temp_array_heap_alloc.f90.in
)

add_executable(use_temp_array_heap_alloc ${CMAKE_CURRENT_BINARY_DIR}/use_temp_array_heap_alloc.f90)
target_link_libraries(use_temp_array_heap_alloc PRIVATE Fortran::TempArrayHeapAlloc_1024)

add_custom_target(run_use_temp_array_heap_alloc ALL
  COMMAND use_temp_array_heap_alloc
)
add_dependencies(run_use_temp_array_heap_alloc use_temp_array_heap_alloc)

if( WIN32 AND EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32)
  add_test(NAME run_use_temp_array_heap_alloc
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}_win32
  )
else()
  add_test(NAME run_use_temp_array_heap_alloc
    COMMAND ${CMAKE_COMMAND} -E compare_files
      ${CMAKE_CURRENT_BINARY_DIR}/terminal_output
      ${CMAKE_CURRENT_SOURCE_DIR}/terminal_output_${CMAKE_Fortran_COMPILER_ID}
  )
endif()
