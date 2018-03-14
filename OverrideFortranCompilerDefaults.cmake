include(Backports/IncludeGuard)
include_guard(GLOBAL)

include(OverrideFortranCompilerDefaults/NoBackslashEscape.cmake)
include(OverrideFortranCompilerDefaults/StandardAdherence.cmake)

add_library(ofcd INTERFACE)
add_library(ofcd::ofcd ALIAS ofcd)

target_link_libraries(ofcd INTERFACE 
  no_backslash_escape
  standard_semantics
)

