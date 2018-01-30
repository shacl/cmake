string(CONCAT generator
  "$<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},GNU>"
    ":$<$<BOOL:FortranTypes.real.64>:-fdefault-real-8;-fdefault-double-8>>")

target_compile_options(Fortran_Real_Fortran INTERFACE ${generator})

unset(generator)