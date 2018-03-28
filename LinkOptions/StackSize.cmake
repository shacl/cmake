include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(LinkOptions_StackSize INTERFACE)
add_library(LinkOptions::StackSize ALIAS LinkOptions_StackSize)

include(LinkOptions/StackSize/GNU)
include(LinkOptions/StackSize/Intel)
include(LinkOptions/StackSize/PGI)
include(LinkOptions/StackSize/LLVM)
