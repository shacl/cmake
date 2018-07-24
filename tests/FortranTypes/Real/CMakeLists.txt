include(FortranTypes)
include(Fortran)

foreach( size 4 8 )
  add_executable(FortranTypes.Real${size}.C.test test.c)
  set_target_properties(FortranTypes.Real${size}.C.test PROPERTIES Fortran_REAL_SIZE_BYTES "${size}")
  target_link_libraries(FortranTypes.Real${size}.C.test PUBLIC FortranTypes::Real_C)
  target_compile_definitions(FortranTypes.Real${size}.C.test PRIVATE EXPECTED=${size})
  add_test(NAME FortranTypes.Real${size}.C.test COMMAND FortranTypes.Real${size}.C.test)

  add_executable(FortranTypes.Real${size}.CXX.test test.cpp)
  set_target_properties(FortranTypes.Real${size}.CXX.test PROPERTIES Fortran_REAL_SIZE_BYTES "${size}")
  target_link_libraries(FortranTypes.Real${size}.CXX.test PUBLIC FortranTypes::Real_CXX)
  target_compile_definitions(FortranTypes.Real${size}.CXX.test PRIVATE EXPECTED=${size})
  add_test(NAME FortranTypes.Real${size}.CXX.test COMMAND FortranTypes.Real${size}.CXX.test)

  add_executable(FortranTypes.Real${size}.Fortran.test test.F90)
  set_target_properties(FortranTypes.Real${size}.Fortran.test PROPERTIES Fortran_REAL_SIZE_BYTES "${size}")
  set_target_properties(FortranTypes.Real${size}.Fortran.test PROPERTIES Fortran_STANDARD 2008)
  target_link_libraries(FortranTypes.Real${size}.Fortran.test PUBLIC  FortranTypes::Real_Fortran)
  add_test(NAME FortranTypes.Real${size}.Fortran.test COMMAND FortranTypes.Real${size}.Fortran.test)
endforeach()


