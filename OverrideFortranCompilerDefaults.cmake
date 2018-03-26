include(Backports/IncludeGuard)
include_guard(GLOBAL)

include(OverrideFortranCompilerDefaults/NoBackslashEscape)
include(OverrideFortranCompilerDefaults/StandardAdherence)

add_library(ofcd INTERFACE)
add_library(ofcd::ofcd ALIAS ofcd)

target_link_libraries(ofcd INTERFACE
  no_backslash_escape
  standard_semantics
)

