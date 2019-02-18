include_guard(GLOBAL)

include(GeneratedSources)

include(FortranPreProcess/FortranPreProcess)
include(FortranPreProcess/filename)
include(FortranPreProcess/target_sources)

install(FILES
  "${CMAKE_CURRENT_LIST_DIR}/FortranPreProcess.cmake"
  DESTINATION share/cmake/shacl/.cmake)

install(DIRECTORY
  "${CMAKE_CURRENT_LIST_DIR}/FortranPreProcess"
  DESTINATION share/cmake/shacl/.cmake)
