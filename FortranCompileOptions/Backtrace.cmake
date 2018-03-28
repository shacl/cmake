include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_Backtrace INTERFACE)
add_library(FortranCompileOptions::Backtrace ALIAS Fortran_Backtrace)

include(FortranCompileOptions/Backtrace/Intel)
include(FortranCompileOptions/Backtrace/PGI)
# traceback with GNU is default
# traceback with Flang is default
