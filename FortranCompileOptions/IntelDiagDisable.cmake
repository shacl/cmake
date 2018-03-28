include(Backports/IncludeGuard)
include_guard(GLOBAL)

if( "Intel" STREQUAL "${CMAKE_Fortran_COMPILER_ID}")
  set(Fortran.Intel.DiagDisable "" CACHE STRING "semicolon-separated list of Intel Fortran diagnostic numbers to dissable")
  mark_as_advanced(Fortran.Intel.DiagDisable)
endif()

add_library(Fortran_IntelDiagDisable INTERFACE)
add_library(FortranCompileOptions::IntelDiagDisable ALIAS Fortran_IntelDiagDisable)

string(CONCAT generator
  "$<$<BOOL:$<JOIN:${Fortran.Intel.DiagDisable},>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-diag-disable;$<JOIN:${Fortran.Intel.DiagDisable},,>>"
      "$<$<PLATFORM_ID:Windows>:/Qdiag-disable:$<JOIN:${Fortran.Intel.DiagDisable},,>>"
    ">"
  ">"
)

target_compile_options(Fortran_IntelDiagDisable INTERFACE ${generator})
