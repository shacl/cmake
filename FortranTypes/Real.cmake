include(Backports/IncludeGuard)
include(CMakeDependentOption)

include_guard(GLOBAL)

add_library(Fortran_Real_C INTERFACE)
target_compile_definitions(Fortran_Real_C INTERFACE
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,4>:F90_REAL_4BYTE>
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_REAL_SIZE_BYTES>,8>:F90_REAL_8BYTE>)
set_property(TARGET Fortran_Real_C APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

add_library(Fortran_Real_CXX INTERFACE)
target_link_libraries(Fortran_Real_CXX INTERFACE Fortran_Real_C)
set_property(TARGET Fortran_Real_CXX APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

add_library(Fortran_Real_Fortran INTERFACE)
target_link_libraries(Fortran_Real_Fortran INTERFACE Fortran_Real_C)
set_property(TARGET Fortran_Real_Fortran APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_REAL_SIZE_BYTES)

include(FortranTypes/Real/GNU)
include(FortranTypes/Real/Flang)
include(FortranTypes/Real/PGI)
include(FortranTypes/Real/Intel)

add_library(FortranTypes::Real_C ALIAS Fortran_Real_C)
add_library(FortranTypes::Real_CXX ALIAS Fortran_Real_CXX)
add_library(FortranTypes::Real_Fortran ALIAS Fortran_Real_Fortran)
