backup(add_executable)

function(add_executable target)
  previous_add_executable(${ARGV})

  get_target_property(is_alias ${target} ALIASED_TARGET)
  get_target_property(is_imported ${target} IMPORTED)
  if(is_alias OR is_imported)
    return()
  endif()

  previous_add_library(${target}.generated_sources.PUBLIC
    INTERFACE IMPORTED GLOBAL)

  target_link_libraries(${target} PUBLIC
    $<BUILD_INTERFACE:${target}.generated_sources.PUBLIC>)

  previous_add_library(${target}.generated_sources.PRIVATE
    INTERFACE IMPORTED GLOBAL)

  target_link_libraries(${target} PRIVATE
    $<BUILD_INTERFACE:${target}.generated_sources.PRIVATE>)

  previous_add_library(${target}.generated_sources.INTERFACE
    INTERFACE IMPORTED GLOBAL)

  target_link_libraries(${target} INTERFACE
    $<BUILD_INTERFACE:${target}.generated_sources.INTERFACE>)
endfunction()
