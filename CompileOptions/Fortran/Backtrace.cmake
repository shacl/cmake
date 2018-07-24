include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_Backtrace INTERFACE)
add_library(CompileOptions::Fortran::Backtrace ALIAS Fortran_Backtrace)

include(CompileOptions/Fortran/Backtrace/Intel)
include(CompileOptions/Fortran/Backtrace/PGI)
# traceback with GNU is default
# traceback with Flang is default
