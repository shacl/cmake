cmake_minimum_required(VERSION 3.12.1)
string(CONCAT shacl.cmake.Fortran.Standard.generator
  "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_STANDARD>,95>:f95>"
  "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_STANDARD>,2003>:f03>"
  "$<$<STREQUAL:$<TARGET_PROPERTY:Fortran_STANDARD>,2008>:f08>")

string(CONCAT shacl.cmake.Fortran.Standard.generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<IF:$<PLATFORM_ID:Windows>,/stand:,-stand=>"
    "${shacl.cmake.Fortran.Standard.generator}>")

target_compile_options(shacl::cmake::Fortran::Standard INTERFACE
  ${shacl.cmake.Fortran.Standard.generator})

unset(shacl.cmake.Fortran.Standard.generator)
