cmake_minimum_required(VERSION 3.10.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_LONGLINES
  BRIEF_DOCS "Allow long lines in Fortran source code"
  FULL_DOCS "Allow long lines in Fortran source code"
)

add_library(shacl::cmake::Fortran::LongLines INTERFACE IMPORTED GLOBAL)

include(Fortran/LongLines/GNU)

install(FILES
  "${CMAKE_CURRENT_LIST_DIR}/LongLines.cmake"
  DESTINATION share/cmake/shacl/.cmake/Fortran)

install(DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/LongLines"
  DESTINATION share/cmake/shacl/.cmake/Fortran)
