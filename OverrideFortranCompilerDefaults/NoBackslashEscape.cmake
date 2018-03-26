include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(no_backslash_escape INTERFACE)
add_library(ofcd::no_backslash_escape ALIAS no_backslash_escape)

target_compile_options(no_backslash_escape INTERFACE
  # treat backslashes as normal (i.e., not escape characters)
  $<$<STREQUAL:Flang,${CMAKE_Fortran_COMPILER_ID}>:-fno-backslash>
  $<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mbackslash>
)
