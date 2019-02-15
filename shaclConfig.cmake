include(CMakeFindDependencyMacro)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/.cmake")

foreach(component IN LISTS shacl_FIND_COMPONENTS)
  if( ${component} STREQUAL "cmake" )
    set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)
  else()
    set(DIR "${CMAKE_CURRENT_LIST_DIR}/${component}")
    find_dependency(${component} ${shacl_PACKAGE_VERSION} HINTS "${DIR}")
  endif()
endforeach()
