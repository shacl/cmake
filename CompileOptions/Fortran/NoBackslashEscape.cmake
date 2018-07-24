include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_NoBackslashEscape INTERFACE)
add_library(CompileOptions::Fortran::NoBackslashEscape ALIAS Fortran_NoBackslashEscape)

include(CompileOptions/Fortran/NoBackslashEscape/Flang)
include(CompileOptions/Fortran/NoBackslashEscape/PGI)
