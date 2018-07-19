string(CONCAT generator
  "$<$<AND:$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>,"
          "$<NOT:$<PLATFORM_ID:Windows>>,"
          "$<BOOL:${FortranTypes.real.64}>>"
    ":-r8>;"
  "$<$<AND:$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>,"
          "$<PLATFORM_ID:Windows>,"
          "$<BOOL:${FortranTypes.real.32}>>"
    ":/real-size:32>;"
  "$<$<AND:$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>,"
          "$<PLATFORM_ID:Windows>,"
          "$<BOOL:${FortranTypes.real.64}>>"
    ":/real-size:64>;")

target_compile_options(Fortran_Real_Fortran INTERFACE ${generator})

string(CONCAT generator
  "$<$<AND:$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>,"
          "$<NOT:$<OR:$<BOOL:${FortranTypes.real.64}>,"
                     "$<BOOL:${FortranTypes.real.32}>>>>:F90_REAL_4BYTE>")

target_compile_definitions(Fortran_Real_C INTERFACE ${generator})

unset(generator)
