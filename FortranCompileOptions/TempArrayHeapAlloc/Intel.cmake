string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
    ":$<$<NOT:$<PLATFORM_ID:Windows>>:-heap-arrays;>"
     "$<$<PLATFORM_ID:Windows>:/heap-arrays:>"
     "$<$<BOOL:$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_Intel>>"
       ":$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_Intel>>"
     "$<$NOT<$<BOOL:$<TARGET_PROPERTY:Fortran_HeapArrays_threshold_Intel>>>"
     ":${Fortran.HeapArrays.threshold.Intel}>>")

target_compile_options(Fortran_HeapArrays INTERFACE ${generator})
