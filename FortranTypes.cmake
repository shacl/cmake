include(Backports/IncludeGuard)
include_guard(GLOBAL)

include(FortranTypes/Integer)
include(FortranTypes/Real)

add_library(FortranTypes_C INTERFACE)
target_link_libraries(FortranTypes_C INTERFACE FortranTypes::Integer_C)
target_link_libraries(FortranTypes_C INTERFACE FortranTypes::Real_C)
add_library(FortranTypes::C ALIAS FortranTypes_C)

add_library(FortranTypes_CXX INTERFACE)
target_link_libraries(FortranTypes_CXX INTERFACE FortranTypes::Integer_CXX)
target_link_libraries(FortranTypes_CXX INTERFACE FortranTypes::Real_CXX)
add_library(FortranTypes::CXX ALIAS FortranTypes_CXX)

add_library(FortranTypes_Fortran INTERFACE)
target_link_libraries(FortranTypes_Fortran INTERFACE FortranTypes::Integer_Fortran)
target_link_libraries(FortranTypes_Fortran INTERFACE FortranTypes::Real_Fortran)
add_library(FortranTypes::Fortran ALIAS FortranTypes_Fortran)

