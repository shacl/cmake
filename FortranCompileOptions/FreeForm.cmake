include(Backports/IncludeGuard)
include_guard(GLOBAL)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

add_library(Fortran_FreeForm INTERFACE)
add_library(Fortran::FreeForm ALIAS Fortran_FreeForm)

include(FreeForm/Intel)
include(FreeForm/GNU)
include(FreeForm/Flang)
include(FreeForm/PGI)
