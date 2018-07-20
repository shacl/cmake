include(Backports/IncludeGuard)
include(CMakeDependentOption)

include_guard(GLOBAL)

add_library(Fortran_Integer_C INTERFACE)
target_compile_definitions(Fortran_Integer_C INTERFACE
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,4>:F90_INT_4BYTE>
  $<$<STREQUAL:$<TARGET_PROPERTY:Fortran_INTEGER_SIZE_BYTES>,8>:F90_INT_8BYTE>)
set_property(TARGET Fortran_Integer_C APPEND PROPERTY COMPATIBLE_INTERFACE_STRING Fortran_INTEGER_SIZE_BYTES)

add_library(Fortran_Integer_CXX INTERFACE)
target_link_libraries(Fortran_Integer_CXX INTERFACE Fortran_Integer_C)

add_library(Fortran_Integer_Fortran INTERFACE)
target_link_libraries(Fortran_Integer_Fortran INTERFACE Fortran_Integer_C)

include(FortranTypes/Integer/GNU)
include(FortranTypes/Integer/Flang)
include(FortranTypes/Integer/PGI)
include(FortranTypes/Integer/Intel)

add_library(FortranTypes::Integer_C ALIAS Fortran_Integer_C)
add_library(FortranTypes::Integer_CXX ALIAS Fortran_Integer_CXX)
add_library(FortranTypes::Integer_Fortran ALIAS Fortran_Integer_Fortran)
