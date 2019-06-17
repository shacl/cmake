string(CONCAT shacl.cmake.Fortran.StackArraySizeLimit.generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<$<BOOL:$<TARGET_PROPERTY:Fortran_STACK_ARRAY_SIZE_LIMIT>>:"
      "$<IF:$<PLATFORM_ID:Windows>,/heap-arrays:,-heap-arrays;>"
      "$<TARGET_PROPERTY:Fortran_TEMP_ARRAY_THRESHOLD>>>")

target_compile_options(shacl::cmake::Fortran::StackArraySizeLimit INTERFACE
  ${shacl.cmake.Fortran.StackArraySizeLimit.generator})

unset(shacl.cmake.Fortran.StackArraySizeLimit.generator)
