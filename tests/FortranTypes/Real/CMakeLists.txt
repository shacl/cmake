include(FortranTypes)
include(FortranCompileOptions)

foreach( size 4 8 )
  add_library(real_size_${size} STATIC size_mod.F90)
  target_link_libraries(real_size_${size} PRIVATE FortranTypes::Real_Fortran)
  set_target_properties(real_size_${size} PROPERTIES 
    INTERFACE_Fortran_REAL_SIZE_BYTES "${size}" 
    Fortran_REAL_SIZE_BYTES "${size}" 
    Fortran_STANDARD 2008
  )

  add_executable(FortranTypes.Real${size}.C.test test.c)
  target_link_libraries(FortranTypes.Real${size}.C.test PUBLIC real_size_${size} FortranTypes::Real_C)
  add_test(NAME FortranTypes.Real${size}.C.test COMMAND FortranTypes.Real${size}.C.test)

  add_executable(FortranTypes.Real${size}.CXX.test test.cpp)
  target_link_libraries(FortranTypes.Real${size}.CXX.test PUBLIC real_size_${size} FortranTypes::Real_CXX)
  add_test(NAME FortranTypes.Real${size}.CXX.test COMMAND FortranTypes.Real${size}.CXX.test)

  add_executable(FortranTypes.Real${size}.Fortran.test test.F90)
  set_target_properties(FortranTypes.Real${size}.Fortran.test PROPERTIES Fortran_STANDARD 2008)
  target_link_libraries(FortranTypes.Real${size}.Fortran.test PUBLIC real_size_${size} FortranTypes::Real_Fortran)
  add_test(NAME FortranTypes.Real${size}.Fortran.test COMMAND FortranTypes.Real${size}.Fortran.test)
endforeach()


