get_property(
  GeneratedSources.stripped.cmake
  GLOBAL PROPERTY GeneratedSources.stripped.cmake SET)

if(NOT GeneratedSources.stripped.cmake)
  macro( stripped target_name )
    string(REPLACE ":" ";" split_target_name "${target_name}")
    list(GET split_target_name -1 stripped_target_name)
    unset(split_target_name)
  macro()
endif()
