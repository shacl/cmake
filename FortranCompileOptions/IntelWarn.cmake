include(Backports/IncludeGuard)
include_guard(GLOBAL)

if( "Intel" STREQUAL "${CMAKE_Fortran_COMPILER_ID}")
  set(Fortran.Intel.Warn "" CACHE STRING "semicolon-separated list of Intel Fortran warning keyword")
  mark_as_advanced(Fortran.Intel.Warn)
endif()

add_library(Fortran_IntelWarn INTERFACE)
add_library(FortranCompileOptions::IntelWarn ALIAS Fortran_IntelWarn)

string(CONCAT generator
  "$<$<BOOL:$<JOIN:${Fortran.Intel.Warn},>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-warn;$<JOIN:${Fortran.Intel.Warn},$<COMMA>>>"
      "$<$<PLATFORM_ID:Windows>:/warn:$<JOIN:${Fortran.Intel.Warn},$<COMMA>>>"
    ">"
  ">"
)

target_compile_options(Fortran_IntelWarn INTERFACE ${generator})
