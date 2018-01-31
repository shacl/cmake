string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>"
    ":$<$<BOOL:${FortranTypes.integer.64}>:-fdefault-integer-8>>")

target_compile_options(Fortran_Integer_Fortran INTERFACE ${generator})

unset(generator)