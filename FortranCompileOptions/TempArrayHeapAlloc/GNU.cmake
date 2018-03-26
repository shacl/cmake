string(CONCAT generator
  "$<$<BOOL:$<TARGET_PEROPERTY:Fortran_TempArrayHeapAlloc,Fortran_TempArrayHeapAlloc_SIZE>:"
    "$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:"
    "-fmax-stack-var-size=$<TARGET_PEROPERTY:Fortran_TempArrayHeapAlloc,Fortran_TempArrayHeapAlloc_SIZE>"
  ">"
)

target_compile_options(Fortran_TempArrayHeapAlloc INTERFACE ${generator})
