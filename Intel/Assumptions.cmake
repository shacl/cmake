include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_ENABLED_ASSUMPTIONS
BRIEF_DOCS
"Intel assumption keywords"
FULL_DOCS
"This property contains zero or more entries specifying assumption options
 used when compiling with an Intel compiler. Each entry corresponds to a
 assumption keyword, e.g., specifying `buffered_io` will add the
 `-assume buffered_io` or `/assume:buffered_io` flag as appropriate for
 the host platform.

 Multiple entries must be semicolon separated e.g. unused;unused")

define_property(TARGET PROPERTY Intel_DISABLED_ASSUMPTIONS
BRIEF_DOCS
"Intel assumption keywords"
FULL_DOCS
"This property contains zero or more entries specifying assumption options
 used when compiling with an Intel compiler. Each entry corresponds to a
 assumption keyword, e.g., specifying `buffered_io` will add the
 `-assume nobuffered_io` or `/assume:nobuffered_io` flag as appropriate for
 the host platform.

 Multiple entries must be semicolon separated e.g. unused;unused")

add_library(Intel_Assumptions_C INTERFACE)
add_library(Intel::Assumptions_C ALIAS Intel_Assumptions_C)

string(CONCAT generator
  "$<$<AND:$<C_COMPILER_ID:Intel>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_ENABLED_ASSUMPTIONS>>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",/assume$<1::>"
        ",-assume;"
     ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_ENABLED_ASSUMPTIONS>,$<COMMA>>"
   ">"
  "$<$<AND:$<C_COMPILER_ID:Intel>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_DISABLED_ASSUMPTIONS>>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",/assume$<1::>no"
        ",-assume;no"
     ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_DISABLED_ASSUMPTIONS>,$<COMMA>no>"
   ">")

target_compile_options(Intel_Assumptions_C INTERFACE ${generator})

add_library(Intel_Assumptions_CXX INTERFACE)
add_library(Intel::Assumptions_CXX ALIAS Intel_Assumptions_CXX)

string(CONCAT generator
  "$<$<AND:$<CXX_COMPILER_ID:Intel>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_ENABLED_ASSUMPTIONS>>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",/assume$<1::>"
        ",-assume;"
     ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_ENABLED_ASSUMPTIONS>,$<COMMA>>"
   ">"
  "$<$<AND:$<CXX_COMPILER_ID:Intel>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_DISABLED_ASSUMPTIONS>>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",/assume$<1::>no"
        ",-assume;no"
     ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_DISABLED_ASSUMPTIONS>,$<COMMA>no>"
   ">")

target_compile_options(Intel_Assumptions_CXX INTERFACE ${generator})

add_library(Intel_Assumptions_Fortran INTERFACE)
add_library(Intel::Assumptions_Fortran ALIAS Intel_Assumptions_Fortran)

string(CONCAT generator
  "$<$<AND:$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_ENABLED_ASSUMPTIONS>>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",/assume$<1::>"
        ",-assume;"
     ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_ENABLED_ASSUMPTIONS>,$<COMMA>>"
   ">"
  "$<$<AND:$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>"
         ",$<BOOL:$<TARGET_PROPERTY:Intel_DISABLED_ASSUMPTIONS>>>"
   ":$<IF:$<PLATFORM_ID:Windows>"
        ",/assume$<1::>no"
        ",-assume;no"
     ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_DISABLED_ASSUMPTIONS>,$<COMMA>no>"
   ">")

target_compile_options(Intel_Assumptions_Fortran INTERFACE ${generator})
