string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>"
    ":$<$<BOOL:${FortranTypes.real.64}>:-fdefault-real-8;-fdefault-double-8>>")

target_compile_options(Fortran_Real_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>"
     ":$<$<NOT:$<OR:$<BOOL:${FortranTypes.real.64}>,"
                  "$<BOOL:${FortranTypes.real.32}>>>:F90_REAL_4BYTE>>")

target_compile_definitions(Fortran_Real_C INTERFACE ${generator})

unset(generator)
