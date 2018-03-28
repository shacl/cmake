string(CONCAT generator
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:-std=f2008>"
)          

target_compile_options(Fortran_Standard2008 INTERFACE ${generator})
