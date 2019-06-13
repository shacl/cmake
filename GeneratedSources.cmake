cmake_minimum_required(VERSION 3.12.1)
include_guard(DIRECTORY)

include("${CMAKE_CURRENT_LIST_DIR}/config.cmake")
if(shacl.cmake.installation)
  get_property(
    shacl.cmake.installed_modules GLOBAL PROPERTY shacl.cmake.installed_modules)

  if(NOT "GeneratedSources" IN_LIST shacl.cmake.installed_modules)
    install(
      FILES "${CMAKE_CURRENT_LIST_FILE}"
      DESTINATION share/cmake/shacl/.cmake)

    install(
      DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/GeneratedSources"
      DESTINATION share/cmake/shacl/.cmake)
  endif()
endif()

include(ListBinaryDir)
include(FunctionExtension)

include_guard(GLOBAL)
include(GeneratedSources/add_library)
include(GeneratedSources/add_executable)
include(GeneratedSources/target_sources)
