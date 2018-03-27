string(CONCAT generator
  "$<$<STREQUAL:Flang,${CMAKE_Fortran_COMPILER_ID}>"
    ":-fmax-stack-var-size=$<$<BOOL:$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_Flang>>"
                            ":$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_Flang>>"
                          "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_Flang>>>"
                            ":${Fortran.HeapArrays.threshold.Flang}>>")

target_compile_options(Fortran_HeapArrays INTERFACE ${generator})

