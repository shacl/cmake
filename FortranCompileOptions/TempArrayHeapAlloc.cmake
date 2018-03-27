include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_HeapArrays INTERFACE)
add_library(Fortran::HeapArrays ALIAS Fortran_HeapArrays)

set(Fortran_HeapArrays_threshold 32768 CACHE STRING 
  "A threshold (in bytes) for heap allocated temporary and automatic arrays")

mark_as_advanced(Fortran_HeapArrays_threshold)

math(EXPR Fortran_HeapArrays_threshold_kb 
  "${Fortran_HeapArrays_threshold} * 1000")

set(Fortran_HeapArrays_threshold_Intel ${Fortran_HeapArrays_threshold_kb}
  CACHE INTERNAL "" FORCE)

set(Fortran_HeapArrays_threshold_GNU ${Fortran_HeapArrays_threshold}
  CACHE INTERNAL "" FORCE)

set(Fortran_HeapArrays_threshold_Flang ${Fortran_HeapArrays_threshold}
  CACHE INTERNAL "" FORCE)

unset(Fortran_HeapArrays_threshold_kb)

# Respects Fortran_HeapArrays_threshold_<vendor id> target property
# if populated on the target. Otherwise, falls back to the values
# in the internal cache variable
include(FortranCompileOptions/TempArrayHeapAlloc/GNU)
include(FortranCompileOptions/TempArrayHeapAlloc/Flang)
include(FortranCompileOptions/TempArrayHeapAlloc/Intel)
include(FortranCompileOptions/TempArrayHeapAlloc/PGI)

