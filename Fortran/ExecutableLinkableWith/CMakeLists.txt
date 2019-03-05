cmake_minimum_required(VERSION 3.12.1)
project(fortran_links_with LANGUAGES Fortran ${LINK_LANGUAGE})

set(linker_language Fortran)
if(LINK_LANGUAGE)
  set(linker_language ${LINK_LANGUAGE})
endif()

add_executable(linkable linkable.f90)
set_target_properties(linkable PROPERTIES 
  LINKER_LANGUAGE ${linker_language})
