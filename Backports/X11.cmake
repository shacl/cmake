get_property(Backports.X11.cmake GLOBAL PROPERTY Backports.X11.cmake SET)

if(NOT Backports.X11.cmake)
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/X11")
  set_property(GLOBAL PROPERTY Backports.X11.cmake "This is a header guard")
endif()
