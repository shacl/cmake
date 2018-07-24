include(FortranTypes)
include(CompileOptions/Fortran)

foreach( size 4 8 )
  add_library(int_size_${size} STATIC size_mod.F90)
  target_link_libraries(int_size_${size} PRIVATE FortranTypes::Integer_Fortran)
  set_target_properties(int_size_${size} PROPERTIES 
    INTERFACE_Fortran_INTEGER_SIZE_BYTES "${size}" 
    Fortran_INTEGER_SIZE_BYTES "${size}" 
    Fortran_STANDARD 2008
  )

  add_executable(FortranTypes.Integer${size}.C.test test.c)
  target_link_libraries(FortranTypes.Integer${size}.C.test PUBLIC int_size_${size} FortranTypes::Integer_C)
  add_test(NAME FortranTypes.Integer${size}.C.test COMMAND FortranTypes.Integer${size}.C.test)

  add_executable(FortranTypes.Integer${size}.CXX.test test.cpp)
  target_link_libraries(FortranTypes.Integer${size}.CXX.test PUBLIC int_size_${size} FortranTypes::Integer_CXX)
  add_test(NAME FortranTypes.Integer${size}.CXX.test COMMAND FortranTypes.Integer${size}.CXX.test)

  add_executable(FortranTypes.Integer${size}.Fortran.test test.F90)
  set_target_properties(FortranTypes.Integer${size}.Fortran.test PROPERTIES Fortran_STANDARD 2008)
  target_link_libraries(FortranTypes.Integer${size}.Fortran.test PUBLIC int_size_${size} FortranTypes::Integer_Fortran)
  add_test(NAME FortranTypes.Integer${size}.Fortran.test COMMAND FortranTypes.Integer${size}.Fortran.test)
endforeach()


