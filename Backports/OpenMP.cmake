get_property(Backports.OpenMP.cmake GLOBAL PROPERTY Backports.OpenMP.cmake SET)

if(NOT Backports.OpenMP.cmake)
  if(CMAKE_VERSION VERSION_LESS_EQUAL 3.9.6)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/OpenMP")
  endif()
  set_property(GLOBAL PROPERTY Backports.OpenMP.cmake "This is a header guard")
endif()
