string(CONCAT shacl.cmake.Fortran.BackslashEscape.generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<IF:$<BOOL:$<TARGET_PROPERTY:Fortran_BACKSLASH_ESCAPE>>"
        ",$<IF:$<PLATFORM_ID:WINDOWS>"
             ",/assume:bscc"
             ",\"$SHELL:-assume bscc\">"
        ",$<IF:$<PLATFORM_ID:WINDOWS>"
             ",/assume:no-bscc"
             ",\"$SHELL:-assume no-bscc\">>>"

target_compile_options(shacl::cmake::Fortran::BackslashEscape INTERFACE
  ${shacl.cmake.Fortran.BackslashEscape.generator})

unset(shacl.cmake.Fortran.BackslashEscape.generator)
