include(Backports/IncludeGuard)
include_guard(GLOBAL)

if( "Intel" STREQUAL "${CMAKE_Fortran_COMPILER_ID}")
  set(Fortran.Intel.Warn "" CACHE STRING "comma-separated list of Intel Fortran warning keyword")
  mark_as_advanced(Fortran.Intel.Warn)

  string(REPLACE "," " " Fortran_Intel_Warn "${Fortran.Intel.Warn}")
endif()

add_library(Fortran_IntelWarn INTERFACE)
add_library(FortranCompileOptions::IntelWarn ALIAS Fortran_IntelWarn)

string(CONCAT generator
  "$<$<BOOL:$<JOIN:${Fortran_Intel_Warn},>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-warn;$<JOIN:${Fortran.Intel.Warn},,>>"
      "$<$<PLATFORM_ID:Windows>:/warn:$<JOIN:${Fortran.Intel.Warn},,>>"
    ">"
  ">"
)

target_compile_options(Fortran_IntelWarn INTERFACE ${generator})
