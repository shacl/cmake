include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_Fortran_WARN
BRIEF_DOCS
"Intel Fortran warning keywords"
FULL_DOCS
"This property contains zero or more entries.
 Each entry corresponds to a warning keyword
 
 multiple entries must be semicolon separated e.g. unused;unused")

add_library(Intel_Warn_Fortran INTERFACE)
add_library(Intel::Warn_Fortran ALIAS Intel_Warn_Fortran)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_Fortran_WARN>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-warn;$<JOIN:$<TARGET_PROPERTY:Intel_Fortran_WARN>,$<COMMA>>>"
      "$<$<PLATFORM_ID:Windows>:/warn:$<JOIN:$<TARGET_PROPERTY:Intel_Fortran_WARN>,$<COMMA>>>"
    ">"
  ">"
)

target_compile_options(Intel_Warn_Fortran INTERFACE ${generator})
