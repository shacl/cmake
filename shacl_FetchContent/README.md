shacl FetchContent 
=====

shacl::cmake's FetchContent functions 
`shacl_FetchContent_MakeAvailable` and `shacl_FetchContent_Declare` are 
are thin wrappers on top of the standard CMake 3.24+ implementation of 
`FetchContent_Declare` and `FetchContent_MakeAvailable`.
The intent of this CMake module to provide a means of managing, recording,
and sharing software dependency usage during software development. This module
leverages features provided via CMake while adjusting defaults to avoid 
surprises during code development.

It provides the following for each dependency with name <PackageName>:
  * Enables relative URLs in the `GIT_REPOSITORY` argument
  * First calls `find_package(<PackageName>)` by default if `FIND_PACKAGE_ARGS` was not specified in the call to `shacl_FetchContent_Declare`
  * Sets the default value of `FETCHCONTENT_UPDATES_DISCONNECTED_<PackageName>` to `ON`
  * Prints information about where dependencies were found whether they were found via system install or fetched

In order to incorporate this functionality into your CMake
project, add the following lines to your project's highest level `CMakeLists.txt`.

```cmake
list(APPEND CMAKE_MODULE_PATH path/to/shacl-cmake)
include(shacl_FetchContent)
```

The following is a list of features and common use cases.
The wrapper functions default back to the standard CMake conventions, documentation for
which can be found in [CMake's FetchContent documentation](https://cmake.org/cmake/help/latest/module/FetchContent.html#fetchcontent)

## Relative URLs
The `shacl_FetchContent_Declare` method enables use of relative URLs in the `GIT_REPOSITORY` argument.
Use of relative URLs relies on the project containing a .git repository with a remote with name "origin".
As an example, if the parent repository's remote URL is https://github.com/shacl/cmake.git and 
`shacl_FetchContent_Declare` function contains `GIT_REPOSITORY ../../shacl/trait.git` then the 
`GIT_REPOSITORY` key-value pair will be modified and passed to `FetchContent_Declare` as 
`GIT_REPOSITORY https://github.com/shacl/trait.git`.

## Integration with find_package 
Since CMake 3.24 FetchContent can first try finding <PackageName> via a call to `find_package` with arguments
specified after `FIND_PACKAGE_ARGS` in the call to `shacl_FetchContent_Declare`. This is provided directly via
CMake's FetchContent commands.  This module simply opts in to by default always call `find_package` first
unless `OVERRIDE_FIND_PACKAGE` is specified in the call to `shacl_FetchContent_Declare`.  If `OVERRIDE_FIND_PACKAGE`
is specified then the package is fetched and future calls to `find_package` will find the fetched package.
`shacl_FetchContent` also provides a variable to opt-in to `OVERRIDE_FIND_PACKAGE` at configure time.
If `shacl.fetchcontent.<PackageName>.override_find_package` is set to `ON` then it will act as though 
`OVERRIDE_FIND_PACKAGE` was specified in `shacl_FetchContent_Declare` and will ignore `FIND_PACKAGE_ARGS`
if it was specified.  By default `FetchContent_Declare` does not allow `FIND_PACKAGE_ARGS` to be specified 
alongside `OVERRIDE_FIND_PACKAGE` so this capability is unique to `shacl_FetchContent_Declare`.


## Updating or changing checked-out code
There are several ways to change the branch/tag.

1) Change the `GIT_TAG` entry in the call to `shacl_FetchContent_Declare(<PackageName> ...)` either in the first configure or later configures with `FETCHCONTENT_UPDATES_DISCONNECTED_<PackageName>` set to `OFF`.
2) Navigate into the source directory where <PackageName> was cloned and check out a different branch.  This can be done safely if `FETCHCONTENT_UPDATES_DISCONNECTED_<PackageName>` is set to `ON`.
3) Specify `FETCHCONTENT_SOURCE_DIR_<PACKAGENAME>=/path/to/source` where <PACKAGENAME> is <PackageName> in upper-case.

The `shacl_FetchContent` module defaults `FETCHCONTENT_UPDATES_DISCONNECTED_<PackageName>` to `ON`.
This enables one to modify the code in the source directory and check out different branches without
the changes being overwritten or a different branch getting checked out.
The default behavior of `FetchContent_Declare` is to set this value to OFF, which on a CMake reconfigure
will check out the branch listed in the `GIT_TAG` argument.
To update the code to what is specified in the build system one can either navigate to <PackageName>'s source
directory and update the code there or set `FETCHCONTENT_UPDATES_DISCONNECTED_<PackageName>` to `OFF` to 
have FetchContent update the branch from the git remote.

## Viewing what was set during configure
The repository URL, git tag/branch, and git hash are all saved in
read-only CMake cache variables viewable in the CMakeCache.txt file.
The variables are `shacl.fetchcontent.repository.ro`, `shacl.fetchcontent.tag.ro`, and `shacl.fetchcontent.hash.ro`, respectively.
Changing these variables will not affect the build system and any changes will be overwritten on the following configure.
They are only present to save what was checked out during the configure stage.

