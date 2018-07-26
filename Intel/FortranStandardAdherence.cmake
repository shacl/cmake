include(Backports/IncludeGuard)
include(Intel/FortranAssumptions)
include_guard(GLOBAL)

# Standard-semantics options for Intel

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-standard-semantics;>"
          "$<$<PLATFORM_ID:Windows>:/standard-semantics;>>")

add_library(Intel_Fortran_StandardAdherence INTERFACE)
add_library(Intel::FortranStandardAdherence ALIAS Intel_Fortran_StandardAdherence)

set_target_properties(Intel_Fortran_StandardAdherence PROPERTIES
  INTERFACE_Intel_DISABLED_ASSUMPTIONS std_mod_proc_name)
set_property(TARGET Intel_Fortran_StandardAdherence APPEND PROPERTY
  COMPATIBLE_INTERFACE_STRING Intel_DISABLED_ASSUMPTIONS)

target_compile_options(Intel_Fortran_StandardAdherence INTERFACE
  ${generator})
target_link_libraries(Intel_Fortran_StandardAdherence INTERFACE Intel::FortranAssumptions)
