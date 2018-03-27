target_compile_options(Fortran_HeapArrays INTERFACE
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mnostack_arrays>")