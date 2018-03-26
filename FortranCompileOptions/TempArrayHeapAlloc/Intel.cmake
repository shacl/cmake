string(CONCAT generator
  "$<$<BOOL:$<TARGET_PEROPERTY:Fortran_TempArrayHeapAlloc,Fortran_TempArrayHeapAlloc_SIZE>:"
    "$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:"
    "-heap-arrays;$<TARGET_PEROPERTY:Fortran_TempArrayHeapAlloc,Fortran_TempArrayHeapAlloc_SIZE>"
    "$<$<PLATFORM_ID:Windows>:"
    "/heap-arrays:$<TARGET_PEROPERTY:Fortran_TempArrayHeapAlloc,Fortran_TempArrayHeapAlloc_SIZE>>"
  ">"
)

target_compile_options(Fortran_TempArrayHeapAlloc INTERFACE ${generator})
