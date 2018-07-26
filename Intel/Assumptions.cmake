include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_ENABLED_ASSUMPTIONS
BRIEF_DOCS
"Intel assumption keywords"
FULL_DOCS
"This property contains zero or more entries specifying assumption options
 used when compiling with the Intel Fortran compiler. Each entry corresponds
 to an assumption keyword, e.g., specifying `buffered_io` will add the
 `-assume buffered_io` or `/assume:buffered_io` flag as appropriate for
 the host platform.

 Multiple entries must be semicolon separated e.g. unused;unused")

define_property(TARGET PROPERTY Intel_DISABLED_ASSUMPTIONS
BRIEF_DOCS
"Intel assumption keywords"
FULL_DOCS
"This property contains zero or more entries specifying assumption options
 used when compiling with the Intel Fortran compiler. Each entry corresponds
 to an assumption keyword, e.g., specifying `buffered_io` will add the
 `-assume nobuffered_io` or `/assume:nobuffered_io` flag as appropriate for
 the host platform.

 Multiple entries must be semicolon separated e.g. unused;unused")

add_library(Intel_Assumptions INTERFACE)
add_library(Intel::Assumptions ALIAS Intel_Assumptions)

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
   ":$<IF:$<BOOL:$<TARGET_PROPERTY:Intel_ENABLED_ASSUMPTIONS>>"
        ",$<COMMA>"
        ",$<IF:$<PLATFORM_ID:Windows>"
             ",/assume$<1::>no"
             ",-assume;no"
          ">"
     ">"
    "$<JOIN:$<TARGET_PROPERTY:Intel_DISABLED_ASSUMPTIONS>,$<COMMA>no>"
   ">;")

target_compile_options(Intel_Assumptions INTERFACE ${generator})
