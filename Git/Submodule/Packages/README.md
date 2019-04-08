## Git Submodule Packages ##

The intent of this CMake module to provide a means of managing, recording,
and sharing dependency usage during software development. This module leverages
the git version control system's 'submodule' feature to express dependencies
between (potentially many layers) of CMake projects.

### Git Submodules 101 ###

Git submodules are effectingly a reference from one Git repository to a
particular state of another Git repository. This is expressed within Git as a
tiplet of a url, a commit hash, and an optional branch specification.



`find_package` function to allow git submodules to act as a back-end. The
implementation of this functionality relies on an, admittedly, obscure CMake
feature. Please see documentation/function-extension.md for more information.

In the case that a git submodule does not exist, the `find_package` function
falls back to the traditional behavior.
