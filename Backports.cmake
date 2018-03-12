if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  #set_property( GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON )
endif()

include(${CMAKE_CURRENT_LIST_DIR}/Backports/OpenMP.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Backports/MPI.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Backports/X11.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/Backports/IncludeGuard.cmake)
