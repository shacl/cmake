string(CONCAT generator
  "$<$<BOOL:$<TARGET_PEROPERTY:Fortran_TempArrayHeapAlloc,Fortran_TempArrayHeapAlloc_SIZE>:"
    "$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mnostack_arrays>"
)

target_compile_options(Fortran_TempArrayHeapAlloc INTERFACE ${generator})
