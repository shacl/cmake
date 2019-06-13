string(CONCAT shacl.cmake.Intel.Fortran.StandardCompliance.generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
    "$<IF:$<PLATFORM_ID:Windows>"
        ",/standard-semantics"
        ";\"SHELL:/assume:nostd_mod_proc_name\""
        ",-standard-semantics"
        ";\"SHELL:-assume;nostd_mod_proc_name\">>")

target_compile_options(shacl::cmake::Intel::Fortran::StandardCompliance
  INTERFACE ${shacl.cmake.Intel.Fortran.StandardCompliance.generator})

unset(shacl.cmake.Intel.Fortran.StandardCompliance.generator)
