include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_Fortran_DISABLE_DIAGNOSTICS
BRIEF_DOCS
"Intel Fortran diagnostic numbers to dissable"
FULL_DOCS
"This property contains zero or more entries.
 Each entry is a number corresponding to an 
 intel diagnostic e.g. 1138.
 
 multiple entries must be semicolon separated e.g. 1138;1138")

add_library(Intel_DiagDisable_Fortran INTERFACE)
add_library(CompileOptions::Intel::DiagDisable_Fortran ALIAS Intel_DiagDisable_Fortran)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_Fortran_DISABLE_DIAGNOSTICS>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-diag-disable;$<JOIN:$<TARGET_PROPERTY:Intel_Fortran_DISABLE_DIAGNOSTICS>,$<COMMA>>>"
      "$<$<PLATFORM_ID:Windows>:/Qdiag-disable:$<JOIN:$<TARGET_PROPERTY:Intel_Fortran_DISABLE_DIAGNOSTICS>,$<COMMA>>>"
    ">"
  ">"
)

target_compile_options(Intel_DiagDisable_Fortran INTERFACE ${generator})
