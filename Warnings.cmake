include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(warnings_C INTERFACE)
include(Warnings/C)

add_library(warnings_CXX INTERFACE)
include(Warnings/CXX)

add_library(warnings_Fortran INTERFACE)
include(Warnings/Fortran)

add_library(shacl::warnings_C ALIAS warnings_C)
add_library(shacl::warnings_CXX ALIAS warnings_CXX)
add_library(shacl::warnings_Fortran ALIAS warnings_Fortran)
