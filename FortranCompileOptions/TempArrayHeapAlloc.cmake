include(Backports/IncludeGuard)
include_guard(GLOBAL)

function(MakeTempArrayHeapAllocTarget size)

  set(size_kbytes ${size})
  math(EXPR size_bytes "${size} * 1000")

  if( NOT TARGET Fortran_TempArrayHeapAlloc_${size} )
    add_library(Fortran_TempArrayHeapAlloc_${size} INTERFACE)
    add_library(Fortran::TempArrayHeapAlloc_${size} ALIAS Fortran_TempArrayHeapAlloc_${size})

    target_compile_options(Fortran_TempArrayHeapAlloc_${size} INTERFACE
      "$<$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>:-fmax-stack-var-size=${size_bytes}>"

      "$<$<STREQUAL:Flang,${CMAKE_Fortran_COMPILER_ID}>:-fmax-stack-var-size=${size_bytes}>"

      "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
        "$<$<NOT:$<PLATFORM_ID:Windows>>:-heap-arrays;${size_kbytes}>"
        "$<$<PLATFORM_ID:Windows>:/heap-arrays:${size_kbytes}>"
      ">"

      "$<$<STREQUAL:PGI,${CMAKE_Fortran_COMPILER_ID}>:-Mnostack_arrays>"
    )
  endif()
endfunction()
