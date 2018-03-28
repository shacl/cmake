include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_TempArrayHeapAlloc_THRESHOLD
  BRIEF_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
  FULL_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
)


add_library(Fortran_TempArrayHeapAlloc INTERFACE)
add_library(FortranCompileOptions::TempArrayHeapAlloc ALIAS Fortran_TempArrayHeapAlloc)

include(FortranCompileOptions/TempArrayHeapAlloc/GNU)
include(FortranCompileOptions/TempArrayHeapAlloc/Flang)
include(FortranCompileOptions/TempArrayHeapAlloc/Intel)
include(FortranCompileOptions/TempArrayHeapAlloc/PGI)
