target_compile_options(shacl::cmake::Fortran::TempArrays INTERFACE
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mnostack_arrays>")
