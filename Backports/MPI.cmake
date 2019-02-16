include_guard(GLOBAL)

if(CMAKE_VERSION VERSION_LESS 3.9.6)
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/MPI")
endif()

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/MPI.cmake
  DESTINATION share/cmake/shacl/.cmake/Backports)

install(DIRECTORY
  ${CMAKE_CURRENT_LIST_DIR}/MPI
  DESTINATION share/cmake/shacl/.cmake/Backports)
