include(Backports/IncludeGuard)
include(CMakeDependentOption)

include_guard(GLOBAL)

if(NOT DEFINED FortranTypes.integer.64 
    AND NOT DEFINED FortranTypes.integer.32)
  CMAKE_DEPENDENT_OPTION(FortranTypes.integer.64
    "Require the Fortran default integer be 64-bit integer" OFF
    "NOT FortranTypes.integer.32" OFF)

  CMAKE_DEPENDENT_OPTION(FortranTypes.integer.32
    "Require the Fortran default integer be 32-bit integer" OFF
    "NOT FortranTypes.integer.64" OFF)
endif()

add_library(Fortran_Integer_C INTERFACE)
target_compile_definitions(Fortran_Integer_C INTERFACE
  $<$<BOOL:${FortranTypes.integer.64}>:F90_INT_8BYTE>
  $<$<BOOL:${FortranTypes.integer.32}>:F90_INT_4BYTE>)

add_library(Fortran_Integer_CXX INTERFACE)
target_link_libraries(Fortran_Integer_CXX INTERFACE Fortran_Integer_C)

add_library(Fortran_Integer_Fortran INTERFACE)
target_link_libraries(Fortran_Integer_Fortran INTERFACE Fortran_Integer_C)

include(FortranTypes/Integer/GNU)
include(FortranTypes/Integer/Flang)
include(FortranTypes/Integer/Intel)

add_library(FortranTypes::Integer_C ALIAS Fortran_Integer_C)
add_library(FortranTypes::Integer_CXX ALIAS Fortran_Integer_CXX)
add_library(FortranTypes::Integer_Fortran ALIAS Fortran_Integer_Fortran)
