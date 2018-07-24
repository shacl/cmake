include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_TempArrayHeapAlloc_THRESHOLD
  BRIEF_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
  FULL_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
)


add_library(Fortran_TempArrayHeapAlloc INTERFACE)
add_library(CompileOptions::Fortran::TempArrayHeapAlloc ALIAS Fortran_TempArrayHeapAlloc)

include(CompileOptions/Fortran/TempArrayHeapAlloc/GNU)
# include(CompileOptions/Fortran/TempArrayHeapAlloc/Flang) # not implemented as of 20180716
include(CompileOptions/Fortran/TempArrayHeapAlloc/Intel)
include(CompileOptions/Fortran/TempArrayHeapAlloc/PGI)
