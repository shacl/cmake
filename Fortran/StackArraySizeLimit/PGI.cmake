cmake_minimum_required(VERSION 3.12.1)

target_compile_options(shacl::cmake::Fortran::StackArraySizeLimit INTERFACE
  "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<$<BOOL:$<TARGET_PROPERTY:Fortran_STACK_ARRAY_SIZE_LIMIT>>:"
      "-Mnostack_arrays>>")
