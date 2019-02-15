include_guard(GLOBAL)
include(Batch/Slurm)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Batch.cmake
  DESTINATION share/cmake/shacl/.cmake)
