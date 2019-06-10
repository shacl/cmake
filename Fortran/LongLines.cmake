cmake_minimum_required(VERSION 3.10.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_LONGLINES
  BRIEF_DOCS "Allow long lines in Fortran source code"
  FULL_DOCS "Allow long lines in Fortran source code"
)

add_library(shacl::cmake::Fortran::LongLines INTERFACE IMPORTED GLOBAL)

include(Fortran/LongLines/GNU)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.

add_library(Fortran_LongLines ALIAS shacl::cmake::Fortran::LongLines)
add_library(Fortran::LongLines ALIAS shacl::cmake::Fortran::LongLines)

install(FILES
  "${CMAKE_CURRENT_LIST_DIR}/LongLines.cmake"
  DESTINATION share/cmake/shacl/.cmake/Fortran)

install(DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/LongLines"
  DESTINATION share/cmake/shacl/.cmake/Fortran)
