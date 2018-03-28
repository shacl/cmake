string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>"
    ":$<$<BOOL:$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD>>"
      ":-fmax-stack-var-size=$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD>000"
    ">"
  ">"
)

target_compile_options(Fortran_TempArrayHeapAlloc INTERFACE ${generator})
