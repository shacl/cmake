include(Fortran)

set(expected_GNU_95 "-std=f95")
set(expected_GNU_2003 "-std=f2003")
set(expected_GNU_2008 "-std=f2008")
if(CMAKE_Fortran_COMPILER_VERSION VERSION_LESS "8")
  set(expected_GNU_2018 "-std=f2008ts")
else()
  set(expected_GNU_2018 "-std=f2018")
endif()

set(expected_Flang_95 "")
set(expected_Flang_2003 "")
set(expected_Flang_2008 "")
set(expected_Flang_2018 "")

set(expected_PGI_95 "-Mstandard")
set(expected_PGI_2003 "-Mstandard")
set(expected_PGI_2008 "-Mstandard")
set(expected_PGI_2018 "-Mstandard")

if(WIN32)
  set(prefix "/stand:")
else()
  set(prefix "-stand=")
endif()

set(expected_Intel_95 "${prefix}f95")
set(expected_Intel_2003 "${prefix}f03")
set(expected_Intel_2008 "${prefix}f08")
if(CMAKE_Fortran_COMPILER_VERSION VERSION_LESS "19")
  set(expected_Intel_2018 "${prefix}f15")
else()
  set(expected_Intel_2018 "${prefix}f18")
endif()

foreach(standard 95 2003 2008 2018)
  file(GENERATE
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/f${standard}.f90"
    CONTENT "
program f${standard}
  write(*,'(a)') \"$<TARGET_PROPERTY:Fortran.Standard.${standard},COMPILE_OPTIONS>\"
end program
")

  add_executable(Fortran.Standard.${standard}
    "${CMAKE_CURRENT_BINARY_DIR}/f${standard}.f90")
  set_target_properties(Fortran.Standard.${standard} PROPERTIES Fortran_STANDARD ${standard})
  target_link_libraries(Fortran.Standard.${standard} PRIVATE shacl::cmake::Fortran::Standard)

  add_test(
    NAME shacl.cmake.Fortran.Standard.${standard}
    COMMAND Fortran.Standard.${standard})

  set_tests_properties(shacl.cmake.Fortran.Standard.${standard}
    PROPERTIES
    PASS_REGULAR_EXPRESSION "^${expected_${CMAKE_Fortran_COMPILER_ID}_${standard}}\n$")
endforeach()
