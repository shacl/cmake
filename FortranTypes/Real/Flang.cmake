string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Flang>"
    ":$<$<BOOL:${FortranTypes.real.64}>:-fdefault-real-8>>")

target_compile_options(Fortran_Real_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Flang>"
     ":$<$<NOT:$<OR:$<BOOL:${FortranTypes.integer.64}>,"
                  "$<BOOL:${FortranTypes.integer.32}>>>:F90_REAL_4BYTE>>")

target_compile_definitions(Fortran_Real_C INTERFACE ${generator})

unset(generator)
