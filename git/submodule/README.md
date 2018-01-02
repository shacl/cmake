## the SHACL Git Submodule packages module

The intent of this CMake module extends the functionality of CMake's
`find_package` function to allow git submodules to act as a back-end.
As such, the signature of `find_package` remains unchanged.

```
find_package(<package> [version] [EXACT] [QUIET] [MODULE]
             [REQUIRED] [[COMPONENTS] [components...]]
             [OPTIONAL_COMPONENTS components...]
             [NO_POLICY_SCOPE])
```

In the case that a git submodule does not exist, the function falls back
to the traditional behavior.
