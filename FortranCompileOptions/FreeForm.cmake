include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_FreeForm INTERFACE)
add_library(FortranCompileOptions::FreeForm ALIAS Fortran_FreeForm)

include(FortranCompileOptions/FreeForm/Intel)
include(FortranCompileOptions/FreeForm/GNU)
include(FortranCompileOptions/FreeForm/Flang)
include(FortranCompileOptions/FreeForm/PGI)
