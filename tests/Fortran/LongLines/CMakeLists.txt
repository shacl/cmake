include(Fortran/LongLines)

set(GNU.CYGWIN.ON "-ffree-line-length-none")
set(GNU.Windows.ON "-ffree-line-length-none")
set(GNU.Darwin.ON "-ffree-line-length-none")
set(GNU.Linux.ON "-ffree-line-length-none")

foreach(toggle ON OFF)
  add_executable(longlines.${toggle} "")
  set_target_properties(longlines.${toggle} 
    PROPERTIES Fortran_LONGLINES ${toggle})
  target_link_libraries(longlines.${toggle} PRIVATE shacl::cmake::Fortran::LongLines)  
  set(target longlines.${toggle})

  configure_file(
    ${CMAKE_CURRENT_LIST_DIR}/longlines.f90.in
    ${CMAKE_CURRENT_BINARY_DIR}/longlines.${toggle}.f90.in
    @ONLY)

  file(GENERATE 
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/longlines.${toggle}.f90
    INPUT ${CMAKE_CURRENT_BINARY_DIR}/longlines.${toggle}.f90.in)

  target_sources(longlines.${toggle} PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/longlines.${toggle}.f90)
  add_test(NAME shacl.cmake.Fortran.LongLines.${toggle} COMMAND longlines.${toggle})
  set_tests_properties(shacl.cmake.Fortran.LongLines.${toggle} PROPERTIES
    PASS_REGULAR_EXPRESSION 
    "^${${CMAKE_Fortran_COMPILER_ID}.${CMAKE_HOST_SYSTEM_NAME}.${toggle}}\n$")

endforeach()
