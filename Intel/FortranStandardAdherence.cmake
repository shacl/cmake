include(Backports/IncludeGuard)
include_guard(GLOBAL)

# Standard-semantics options for Intel

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-standard-semantics;-assume;nostd_mod_proc_name>"
          "$<$<PLATFORM_ID:Windows>:/standard-semantics;/assume:nostd_mod_proc_name>>")

add_library(Intel_FortranStandardAdherence INTERFACE)
add_library(Intel::FortranStandardAdherence ALIAS Intel_FortranStandardAdherence)
target_compile_options(Intel_FortranStandardAdherence INTERFACE
  ${generator}
)
