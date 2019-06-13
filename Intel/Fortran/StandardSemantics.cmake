cmake_minimum_required(VERSION 3.12.1)
include_guard(DIRECTORY)

include("${CMAKE_CURRENT_LIST_DIR}/../../config.cmake")
if(shacl.cmake.installation)
  get_property(
    shacl.cmake.installed_modules GLOBAL PROPERTY shacl.cmake.installed_modules)

  if(NOT "Intel/Fortran/StandardSemantics" IN_LIST shacl.cmake.installed_modules)
    set_property(GLOBAL APPEND PROPERTY
      shacl.cmake.installed_modules "Intel/Fortran/StandardSemantics")

    install(
      FILES "${CMAKE_CURRENT_LIST_FILE}"
      DESTINATION share/cmake/shacl/.cmake/Intel/Fortran)
  endif()

  unset(shacl.cmake.installed_modules)
endif()

include(Intel/Fortran/Assumptions)

if(NOT DEFINED CMAKE_Fortran_COMPILER)
  return()
endif()

include_guard(GLOBAL)
add_library(shacl::cmake::Intel::Fortran::StandardSemantics
  INTERFACE IMPORTED GLOBAL)

set_target_properties(shacl::cmake::Intel::Fortran::StandardSemantics PROPERTIES
  INTERFACE_Intel_Fortran_DISABLED_ASSUMPTIONS std_mod_proc_name)

set_property(TARGET shacl::cmake::Intel::Fortran::StandardSemantics APPEND
  PROPERTY COMPATIBLE_INTERFACE_STRING Intel_Fortran_DISABLED_ASSUMPTIONS)

string(CONCAT shacl.cmake.Intel.Fortran.StandardSemantics.generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<IF:$<PLATFORM_ID:Windows>"
        ",/standard-semantics"
        ",-standard-semantics>>")

target_compile_options(shacl::cmake::Intel::Fortran::StandardSemantics
  INTERFACE ${shacl.cmake.Intel.Fortran.StandardSemantics.generator})

unset(shacl.cmake.Intel.Fortran.StandardSemantics.generator)

target_link_libraries(shacl::cmake::Intel::Fortran::StandardSemantics
  INTERFACE shacl::cmake::Intel::Fortran::Assumptions)
