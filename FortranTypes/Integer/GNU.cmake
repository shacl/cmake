string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>"
    ":$<$<BOOL:${FortranTypes.integer.64}>:-fdefault-integer-8>>")

target_compile_options(Fortran_Integer_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<AND:$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>,"
          "$<NOT:$<OR:$<BOOL:${FortranTypes.integer.64}>,"
                     "$<BOOL:${FortranTypes.integer.32}>>>:F90_INT_4BYTE>")

target_compile_definitions(Fortran_Integer_C INTERFACE ${generator})

unset(generator)
