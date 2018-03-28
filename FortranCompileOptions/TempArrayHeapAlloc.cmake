include(Backports/IncludeGuard)
include(FunctionExtensions)
include_guard(GLOBAL)

backup(set_target_properties)
function(set_target_properties)
  list(FIND ARGN "PROPERTIES" pstart)
  
  foreach(i RANGE 0 ${pstart})
    list(GET ARGN ${i} target)
    list(APPEND forward ${target})
  endforeach()

  math(EXPR pstart "${pstart} + 1")
  list(LENGTH ARGN plast)
  math(EXPR plast "${plast} - 1")

  foreach(i RANGE ${pstart} ${plast} 2)
    math(EXPR iv "${i} + 1")
    list(GET ARGV ${i} property)
    list(GET ARGV ${iv} value)

    list(APPEND forward ${property} ${value})
    if( "${property}" STREQUAL "Fortran_TempArrayHeapAlloc_THRESHOLD_BYTES" )
      math(EXPR kbytes "${value} / 1000")
      list(APPEND forward "Fortran_TempArrayHeapAlloc_THRESHOLD_KBYTES" "${kbytes}")
    endif()

    if( "${property}" STREQUAL "Fortran_TempArrayHeapAlloc_THRESHOLD_KBYTES" )
      math(EXPR bytes "${value} * 1000")
      list(APPEND forward "Fortran_TempArrayHeapAlloc_THRESHOLD_BYTES" "${bytes}")
    endif()
  endforeach()

  _set_target_properties(${forward})
endfunction()

add_library(Fortran_TempArrayHeapAlloc INTERFACE)
add_library(FortranCompileOptions::TempArrayHeapAlloc ALIAS Fortran_TempArrayHeapAlloc)

include(FortranCompileOptions/TempArrayHeapAlloc/GNU)
include(FortranCompileOptions/TempArrayHeapAlloc/Flang)
include(FortranCompileOptions/TempArrayHeapAlloc/Intel)
include(FortranCompileOptions/TempArrayHeapAlloc/PGI)
