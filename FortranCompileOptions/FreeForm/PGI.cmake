string(CONCAT generator
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mfree>"
)          

target_compile_options(Fortran_FreeForm INTERFACE ${generator})
