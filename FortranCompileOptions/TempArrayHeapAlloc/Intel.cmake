string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
    ":$<$<BOOL:$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD>>"
      ":$<$<NOT:$<PLATFORM_ID:Windows>>:-heap-arrays;$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD>>"
      "$<$<PLATFORM_ID:Windows>:/heap-arrays:$<TARGET_PROPERTY:Fortran_TempArrayHeapAlloc_THRESHOLD>>"
    ">"
  ">"
)

target_compile_options(Fortran_TempArrayHeapAlloc INTERFACE ${generator})
