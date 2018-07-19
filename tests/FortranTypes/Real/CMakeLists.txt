set(FortranTypes.real.64 ON CACHE INTERNAL "")

include(FortranTypes)
include(FortranCompileOptions)

add_executable(FortranTypes.Real.C.test test.c)
target_link_libraries(FortranTypes.Real.C.test PUBLIC FortranTypes::Real_C)
add_test(NAME FortranTypes.Real.C.test COMMAND FortranTypes.Real.C.test)

add_executable(FortranTypes.Real.CXX.test test.cpp)
target_link_libraries(FortranTypes.Real.CXX.test PUBLIC FortranTypes::Real_CXX)
add_test(NAME FortranTypes.Real.CXX.test COMMAND FortranTypes.Real.CXX.test)

add_executable(FortranTypes.Real.Fortran.test test.f90)
set_target_properties(FortranTypes.Real.Fortran.test PROPERTIES Fortran_STANDARD 2008)
target_link_libraries(FortranTypes.Real.Fortran.test PUBLIC FortranTypes::Real_Fortran)
add_test(NAME FortranTypes.Real.Fortran.test COMMAND FortranTypes.Real.Fortran.test)
