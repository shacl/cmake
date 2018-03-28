include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_Standard2008 INTERFACE)
add_library(FortranCompileOptions::Standard2008 ALIAS Fortran_Standard2008)

include(Standard2008/Intel)
include(Standard2008/GNU)
include(Standard2008/PGI)
# TODO: Flang -- it does not implement standards checking yet
