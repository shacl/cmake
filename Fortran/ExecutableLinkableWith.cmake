cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

set(Fortran_executable_linkable_with_root_dir
  ${CMAKE_CURRENT_LIST_DIR}/ExecutableLinkableWith
  CACHE INTERNAL "")

function(Fortran_executable_linkable_with)
  foreach(lang IN LISTS ARGN)
    if( DEFINED Fortran_executable_linkable_with_${lang} )
      continue()
    endif()

    try_compile(linkable
      ${CMAKE_CURRENT_BINARY_DIR}/FortranExecutableLinkableWith
      ${Fortran_executable_linkable_with_root_dir}
      fortran_links_with linkable
      CMAKE_FLAGS -DLINK_LANGUAGE=${lang})

    if(linkable)
      set(Fortran_executable_linkable_with_${lang} TRUE
        CACHE INTERNAL "")
    else()
      set(Fortran_executable_linkable_with_${lang} FALSE
        CACHE INTERNAL "")
    endif()
  endforeach()
endfunction()
