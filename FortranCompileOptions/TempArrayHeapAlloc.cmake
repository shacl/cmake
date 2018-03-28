include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_TempArrayHeapAlloc INTERFACE)
add_library(FortranCompileOptions::TempArrayHeapAlloc ALIAS Fortran_TempArrayHeapAlloc)

include(FortranCompileOptions/TempArrayHeapAlloc/GNU)
include(FortranCompileOptions/TempArrayHeapAlloc/Flang)
include(FortranCompileOptions/TempArrayHeapAlloc/Intel)
include(FortranCompileOptions/TempArrayHeapAlloc/PGI)
