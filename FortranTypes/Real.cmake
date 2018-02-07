include(Backports/IncludeGuard)
include(CMakeDependentOption)

include_guard(GLOBAL)

CMAKE_DEPENDENT_OPTION(FortranTypes.real.64
  "Require the Fortran default real be 64-bit integer" OFF 
  "NOT FortranTypes.real.32" OFF)

CMAKE_DEPENDENT_OPTION(FortranTypes.real.32
  "Require the Fortran default real be 32-bit integer" OFF 
  "NOT FortranTypes.real.64" OFF)

add_library(Fortran_Real_C INTERFACE)
target_compile_definitions(Fortran_Real_C INTERFACE
  $<$<BOOL:${FortranTypes.real.64}>:F90_REAL_8BYTE>
  $<$<BOOL:${FortranTypes.real.32}>:F90_REAL_4BYTE>)

add_library(Fortran_Real_CXX INTERFACE)
target_link_libraries(Fortran_Real_CXX INTERFACE Fortran_Real_C)

add_library(Fortran_Real_Fortran INTERFACE)
target_link_libraries(Fortran_Real_Fortran INTERFACE Fortran_Real_C)

include(FortranTypes/Real/GNU)
include(FortranTypes/Real/Intel)

add_library(FortranTypes::Real_C ALIAS Fortran_Real_C)
add_library(FortranTypes::Real_CXX ALIAS Fortran_Real_CXX)
add_library(FortranTypes::Real_Fortran ALIAS Fortran_Real_Fortran)