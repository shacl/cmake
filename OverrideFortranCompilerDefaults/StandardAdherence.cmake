include(Backports/IncludeGuard)
include_guard(GLOBAL)

# Standard-semantics options for Intel

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-standard-semantics>"
          "$<$<PLATFORM_ID:Windows>:/standard-semantics>>")

add_library(ofcd::standard_semantics INTERFACE)
target_compile_options(ofcd::standard_semantics INTERFACE
  ${generator}
)

# Standard-enforcement checks

# Fortran 2003

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-stand f03>"
          "$<$<PLATFORM_ID:Windows>:/stand:f03>>"
          
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:-std=f2003")

add_library(ofcd::fortran_2003 INTERFACE)
target_compile_options(ofcd::fortran_2003 INTERFACE
  ${generator}
)

# Fortran 2008

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-stand f08>"
          "$<$<PLATFORM_ID:Windows>:/stand:f08>>"
          
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:-std=f2008")

add_library(ofcd::fortran_2008 INTERFACE)
target_compile_options(ofcd::fortran_2008 INTERFACE
  ${generator}
)
