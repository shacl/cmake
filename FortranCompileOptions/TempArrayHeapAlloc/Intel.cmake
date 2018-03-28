string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
    ":$<$<BOOL:$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD_KBYTES>>"
      ":$<$<NOT:$<PLATFORM_ID:Windows>>:-heap-arrays;$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD_KBYTES>>"
      "$<$<PLATFORM_ID:Windows>:/heap-arrays:$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD_KBYTES>>"
    ">"
  ">"
)

target_compile_options(Fortran_TempArrayHeapAlloc INTERFACE ${generator})
