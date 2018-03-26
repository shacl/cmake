include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_Backtrace INTERFACE)
add_library(Fortran::Backtrace ALIAS Fortran_Backtrace)

include(Backtrace/Intel.cmake)
include(Backtrace/PGI.cmake)
# traceback with GNU is default
# traceback with Flang is default
