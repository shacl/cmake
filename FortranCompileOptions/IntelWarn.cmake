include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_WARN
BRIEF_DOCS
"Intel Fortran warning keywords"
FULL_DOCS
"This property contains zero or more entries.
 Each entry corresponds to a warning keyword
 
 multiple entries must be semicolon separated e.g. unused;unused")

add_library(Fortran_IntelWarn INTERFACE)
add_library(FortranCompileOptions::IntelWarn ALIAS Fortran_IntelWarn)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_WARN>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-warn;$<JOIN:$<TARGET_PROPERTY:Intel_WARN>,$<COMMA>>>"
      "$<$<PLATFORM_ID:Windows>:/warn:$<JOIN:$<TARGET_PROPERTY:Intel_WARN>,$<COMMA>>>"
    ">"
  ">"
)

target_compile_options(Fortran_IntelWarn INTERFACE ${generator})
