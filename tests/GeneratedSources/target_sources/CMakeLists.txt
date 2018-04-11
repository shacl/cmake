cmake_minimum_required(VERSION 3.2.0)
project(shacl_cmake_generated_sources_target_sources LANGUAGES C)

include(CTest)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../..)

include(GeneratedSources)

add_library(foo STATIC baz.c)
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/bar.c "")
file(WRITE baz.c "")

target_sources(foo GENERATED INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/bar.c)
#get_target_property(dependencies foo.generated_sources.INTERFACE MANUALLY_ADDED_DEPENDENCIES)
message("${dependencies}")
