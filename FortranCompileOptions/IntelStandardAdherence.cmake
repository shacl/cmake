include(Backports/IncludeGuard)
include_guard(GLOBAL)

# Standard-semantics options for Intel

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-standard-semantics;-assume;nostd_mod_proc_name>"
          "$<$<PLATFORM_ID:Windows>:/standard-semantics;/assume:nostd_mod_proc_name>>")

add_library(Fortran_IntelStandardAdherence INTERFACE)
add_library(FortranCompileOptions::IntelStandardAdherence ALIAS Fortran_IntelStandardAdherence)
target_compile_options(Fortran_IntelStandardAdherence INTERFACE
  ${generator}
)
