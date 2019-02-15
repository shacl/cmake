target_compile_options(shacl::cmake::Fortran::NoBackslashEscape INTERFACE
  $<$<STREQUAL:Flang,${CMAKE_Fortran_COMPILER_ID}>:-fno-backslash>
)
