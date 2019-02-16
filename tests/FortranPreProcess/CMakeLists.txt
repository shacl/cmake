include(FortranPreProcess)

add_executable(fprepro "")
target_compile_definitions(fprepro PRIVATE DO_F_PRE_PRO)
target_sources(fprepro PREPROCESS PRIVATE 
  "${CMAKE_CURRENT_LIST_DIR}/fprepro.F90"
)

add_test(NAME shacl.cmake.FortranPreProcess
  COMMAND fprepro)
