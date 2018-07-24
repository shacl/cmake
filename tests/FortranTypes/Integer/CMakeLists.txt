include(FortranTypes)
include(Fortran)

foreach( size 4 8 )
  add_executable(FortranTypes.Integer${size}.C.test test.c)
  set_target_properties(FortranTypes.Integer${size}.C.test PROPERTIES Fortran_INTEGER_SIZE_BYTES "${size}")
  target_link_libraries(FortranTypes.Integer${size}.C.test PUBLIC FortranTypes::Integer_C)
  target_compile_definitions(FortranTypes.Integer${size}.C.test PRIVATE EXPECTED=${size})
  add_test(NAME FortranTypes.Integer${size}.C.test COMMAND FortranTypes.Integer${size}.C.test)

  add_executable(FortranTypes.Integer${size}.CXX.test test.cpp)
  set_target_properties(FortranTypes.Integer${size}.CXX.test PROPERTIES Fortran_INTEGER_SIZE_BYTES "${size}")
  target_link_libraries(FortranTypes.Integer${size}.CXX.test PUBLIC FortranTypes::Integer_CXX)
  target_compile_definitions(FortranTypes.Integer${size}.CXX.test PRIVATE EXPECTED=${size})
  add_test(NAME FortranTypes.Integer${size}.CXX.test COMMAND FortranTypes.Integer${size}.CXX.test)

  add_executable(FortranTypes.Integer${size}.Fortran.test test.F90)
  set_target_properties(FortranTypes.Integer${size}.Fortran.test PROPERTIES Fortran_STANDARD 2008)
  set_target_properties(FortranTypes.Integer${size}.Fortran.test PROPERTIES Fortran_INTEGER_SIZE_BYTES "${size}")
  target_link_libraries(FortranTypes.Integer${size}.Fortran.test PUBLIC FortranTypes::Integer_Fortran)
  add_test(NAME FortranTypes.Integer${size}.Fortran.test COMMAND FortranTypes.Integer${size}.Fortran.test)
endforeach()


