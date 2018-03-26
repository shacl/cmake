string(CONCAT generator
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-traceback"
)          

target_compile_options(Fortran_Backtrace INTERFACE ${generator})
