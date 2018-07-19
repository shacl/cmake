set(FortranTypes.integer.64 ON CACHE INTERNAL "")

include(FortranTypes)
include(FortranCompileOptions)

add_executable(FortranTypes.Integer.C.test test.c)
target_link_libraries(FortranTypes.Integer.C.test PUBLIC FortranTypes::Integer_C)
add_test(NAME FortranTypes.Integer.C.test COMMAND FortranTypes.Integer.C.test)

add_executable(FortranTypes.Integer.CXX.test test.cpp)
target_link_libraries(FortranTypes.Integer.CXX.test PUBLIC FortranTypes::Integer_CXX)
add_test(NAME FortranTypes.Integer.CXX.test COMMAND FortranTypes.Integer.CXX.test)

add_executable(FortranTypes.Integer.Fortran.test test.f90)
set_target_properties(FortranTypes.Integer.Fortran.test PROPERTIES Fortran_STANDARD 2008)
target_link_libraries(FortranTypes.Integer.Fortran.test PUBLIC FortranTypes::Integer_Fortran)
add_test(NAME FortranTypes.Integer.Fortran.test COMMAND FortranTypes.Integer.Fortran.test)
