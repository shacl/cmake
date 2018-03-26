include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_FreeForm INTERFACE)
add_library(Fortran::FreeForm ALIAS Fortran_FreeForm)

include(FreeForm/Intel.cmake)
include(FreeForm/GNU.cmake)
include(FreeForm/Flang.cmake)
include(FreeForm/PGI.cmake)
