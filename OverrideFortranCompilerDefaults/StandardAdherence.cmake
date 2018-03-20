include(Backports/IncludeGuard)
include_guard(GLOBAL)

# Standard-semantics options for Intel

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-standard-semantics>"
          "$<$<PLATFORM_ID:Windows>:/standard-semantics>>")

add_library(standard_semantics INTERFACE)
add_library(ofcd::standard_semantics ALIAS standard_semantics)
target_compile_options(standard_semantics INTERFACE
  ${generator}
)

# Standard-enforcement checks

# Fortran 2003

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-stand;f03>"
          "$<$<PLATFORM_ID:Windows>:/stand:f03>>"
          
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:-std=f2003")

add_library(fortran_2003 INTERFACE)
add_library(ofcd::fortran_2003 ALIAS fortran_2003)
target_compile_options(fortran_2003 INTERFACE
  ${generator}
)

# Fortran 2008

string(CONCAT generator
  "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-stand;f08>"
          "$<$<PLATFORM_ID:Windows>:/stand:f08>>"
          
  "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:-std=f2008")

add_library(fortran_2008 INTERFACE)
add_library(ofcd::fortran_2008 ALIAS fortran_2008)
target_compile_options(fortran_2008 INTERFACE
  ${generator}
)
