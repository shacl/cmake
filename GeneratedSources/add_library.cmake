backup(add_library)

function(add_library target keyword)
  previous_add_library(${ARGV})
    
  get_target_property(is_alias ${target} ALIASED_TARGET)
  get_target_property(is_imported ${target} IMPORTED)
  get_target_property(library_type ${target} TYPE)

  if(is_alias OR is_imported)
    return()
  endif()

  stripped(${target})

  if(NOT library_type STREQUAL "INTERFACE_LIBRARY")
    previous_add_library(${stripped_target_name}.generated_sources.PUBLIC INTERFACE)
    target_link_libraries(${target} PUBLIC 
      $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.PUBLIC>)

    previous_add_library(${stripped_target_name}.generated_sources.PRIVATE INTERFACE)
    target_link_libraries(${target} PRIVATE 
      $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.PRIVATE>)
  endif()

  previous_add_library(${stripped_target_name}.generated_sources.INTERFACE INTERFACE)
  target_link_libraries(${target} INTERFACE 
    $<BUILD_INTERFACE:${stripped_target_name}.generated_sources.INTERFACE>)
endfunction()
