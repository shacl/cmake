include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_Fortran_FLOATING_POINT_MODEL
BRIEF_DOCS
"Intel Fortran floating point model"
FULL_DOCS
"This property specifies the Intel floating-point model to apply.
Options are: precise, fast[=1|2], consistent, strict, source"
)

set(intel.fpmodel.default "consistent" CACHE STRING
  "the default selection for the floating-point model flag"
)
mark_as_advanced(intel.fpmodel.default)

add_library(Intel_FPModel_Fortran INTERFACE)
add_library(Intel::FPModel_Fortran ALIAS Intel_FPModel_Fortran)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_Fortran_FLOATING_POINT_MODEL>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-model;$<TARGET_PROPERTY:Intel_Fortran_FLOATING_POINT_MODEL>>"
      "$<$<PLATFORM_ID:Windows>:/fp:$<TARGET_PROPERTY:Intel_Fortran_FLOATING_POINT_MODEL>>"
    ">"
  ">"
)

target_compile_options(Intel_FPModel_Fortran INTERFACE ${generator})
