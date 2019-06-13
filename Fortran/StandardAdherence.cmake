cmake_minimum_required(VERSION 3.12.1)
include_guard(DIRECTORY)

include("${CMAKE_CURRENT_LIST_DIR}/../config.cmake")
if(shacl.cmake.installation)
  get_property(
    shacl.cmake.installed_modules GLOBAL PROPERTY shacl.cmake.installed_modules)

  if(NOT "Fortran/StandardAdherence" IN_LIST shacl.cmake.installed_modules)
    set_property(GLOBAL APPEND PROPERTY
      shacl.cmake.installed_modules "Fortran/StandardAdherence")

    install(
      FILES "${CMAKE_CURRENT_LIST_FILE}"
      DESTINATION share/cmake/shacl/.cmake/Fortran)
  endif()
endif()

include(Fortran/BackslashEscape)
include(Intel/Fortran/StandardSemantics)

include_guard(GLOBAL)
add_library(shacl::cmake::Fortran::StandardAdherence INTERFACE IMPORTED GLOBAL)

target_link_libraries(shacl::cmake::Fortran::StandardAdherence INTERFACE
  shacl::cmake::Fortran::BackslashEscape
  shacl::cmake::Intel::Fortran::StandardSemantics)
