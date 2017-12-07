include(CMakeDependentOption)

function(git.submodule.list)
  if(EXISTS "${PROJECT_SOURCE_DIR}/.gitmodules")
    execute_process(
      COMMAND "${GIT_EXECUTABLE} config --file .gitmodules --name-only --get-regexp path"
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
      OUTPUT_VARIABLE output)

    set(output ${output})

    foreach(entry IN LIST output)
      if(EXISTS ${entry})
        get_filename_component(name ${entry} NAME)
        list(APPEND submodules ${name})

        CMAKE_DEPENDENT_OPTION(
          ${name}_submodule
          "Use dependency submodule rather than system installations" ON
          "git.submodule.packages" OFF)

        set(${name}_submodule_path
          "${PROJECT_SOURCE_DIR}/${entry}"
          CACHE PATH "Absolute path to ${name} git submodule")
      endif()
    endforeach()
  endif()

  set(${CMAKE_PROJECT_NAME}_submodules
    ${submodules} CACHE INTERNAL
    "A CMake list of git submodules for ${CMAKE_PROJECT_NAME}")
endfunction()

git.submodule.list()
