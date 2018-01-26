get_property(Backports.MPI.cmake GLOBAL PROPERTY Backports.MPI.cmake SET)

if(NOT Backports.MPI.cmake)
  if(CMAKE_VERSION VERSION_LESS_EQUAL 3.9.6)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/MPI")
  endif()
  set_property(GLOBAL PROPERTY Backports.MPI.cmake "This is a header guard")
endif()
