set_property( GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON )

include(Backports/OpenMP)
include(Backports/MPI)
include(Backports/X11)
include(Backports/SeparateArguments)
include(Backports/IncludeGuard)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Backports.cmake
  DESTINATION share/cmake/shacl/.cmake)
