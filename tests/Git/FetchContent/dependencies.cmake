
# Test with URL provided
shacl_FetchContent_Declare( Catch2
    GIT_REPOSITORY  ssh://git@asc-git.lanl.gov:10022/catchorg/catch2
    GIT_TAG         master 
    GIT_SHALLOW     TRUE
    FIND_PACKAGE_ARGS 2.0
)

# First-in wins - these values are effectively ignored
shacl_FetchContent_Declare( Catch2
    GIT_REPOSITORY  nonsense 
    GIT_TAG         morenonsense
)

# Test with relative path
# shacl-trait also depends on Catch2
shacl_FetchContent_Declare( shacl-trait
    GIT_REPOSITORY  ../trait
    GIT_TAG         master
    GIT_SUBMODULES  ".gitmodules"
    GIT_SHALLOW     TRUE
)

# Test with another relative path
shacl_FetchContent_Declare( pybind11
    GIT_REPOSITORY  ../../pybind/pybind11
    GIT_TAG         master
    GIT_SHALLOW     TRUE
)

shacl_FetchContent_MakeAvailable(shacl-trait pybind11 Catch2)
