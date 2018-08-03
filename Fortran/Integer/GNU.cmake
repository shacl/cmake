string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>:"
    "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,8>:-fdefault-integer-8>"
  ">"
)

target_compile_options(Integer_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>:"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>>>:F90_INT_4BYTE>"
  ">"
)

target_compile_definitions(Integer_C INTERFACE ${generator})


unset(generator)
