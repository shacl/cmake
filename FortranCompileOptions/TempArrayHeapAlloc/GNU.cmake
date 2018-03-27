string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>"
    ":-fmax-stack-var-size=$<$<BOOL:$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_GNU>>"
                            ":$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_GNU>>"
                          "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_GNU>>>"
                            ":${Fortran.HeapArrays.threshold.GNU}>")

target_compile_options(Fortran_HeapArrays INTERFACE ${generator})

