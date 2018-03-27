include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_Backtrace INTERFACE)
add_library(Fortran::Backtrace ALIAS Fortran_Backtrace)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

include(Backtrace/Intel)
include(Backtrace/PGI)
# traceback with GNU is default
# traceback with Flang is default
