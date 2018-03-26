include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_Standard2008 INTERFACE)
add_library(Fortran::Standard2008 ALIAS fortran_Standard2008

include(Standard2008/Intel.cmake)
include(Standard2008/GNU.cmake)
include(Standard2008/PGI.cmake)
# TODO: Flang -- it does not implement standards checking yet
