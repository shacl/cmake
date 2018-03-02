include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(bad_fortran_defaults INTERFACE)
target_compile_options(bad_fortran_defaults INTERFACE
  # treat backslashes as normal (i.e., not escape characters)
  $<$<STREQUAL:Flang,${CMAKE_Fortran_COMPILER_ID}>:-fno-backslash>
  $<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mbackslash>
)
