target_compile_options(shacl::cmake::Fortran::NoBackslashEscape INTERFACE
  $<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mbackslash>
)
