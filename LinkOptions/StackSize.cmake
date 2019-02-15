include_guard(GLOBAL)

define_property(TARGET PROPERTY LINK_STACK_SIZE
  BRIEF_DOCS "minimum link-time stack size in bytes to be set by the linker"
  FULL_DOCS "minimum link-time stack size in bytes to be set by the linker")

add_library(shacl::cmake::LinkOptions::StackSize INTERFACE IMPORTED GLOBAL)
add_library(LinkOptions_StackSize ALIAS shacl::cmake::LinkOptions::StackSize)
add_library(LinkOptions::StackSize ALIAS shacl::cmake::LinkOptions::StackSize)

include(LinkOptions/StackSize/GNU)
include(LinkOptions/StackSize/Intel)
include(LinkOptions/StackSize/PGI)
include(LinkOptions/StackSize/LLVM)
include(LinkOptions/StackSize/MSVC)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/StackSize.cmake
  DESTINATION share/cmake/shacl/.cmake/LinkOptions)

install(DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/StackSize
  DESTINATION share/cmake/shacl/.cmake/LinkOptions/)
