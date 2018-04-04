include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_DISABLE_DIAGNOSTICS
BRIEF_DOCS
"Intel Fortran diagnostic numbers to dissable"
FULL_DOCS
"This property contains zero or more entries.
 Each entry is a number corresponding to an 
 intel diagnostic e.g. 1138.")

add_library(Fortran_IntelDiagDisable INTERFACE)
add_library(FortranCompileOptions::IntelDiagDisable ALIAS Fortran_IntelDiagDisable)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_DISABLE_DIAGNOSTICS>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-diag-disable;$<JOIN:$<TARGET_PROPERTY:Intel_DISABLE_DIAGNOSTICS>,$<COMMA>>>"
      "$<$<PLATFORM_ID:Windows>:/Qdiag-disable:$<JOIN:$<TARGET_PROPERTY:Intel_DISABLE_DIAGNOSTICS>,$<COMMA>>>"
    ">"
  ">"
)

target_compile_options(Fortran_IntelDiagDisable INTERFACE ${generator})
