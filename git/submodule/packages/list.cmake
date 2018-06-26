function(git_submodule_list)
  if(EXISTS "${PROJECT_SOURCE_DIR}/.gitmodules")
    execute_process(
      COMMAND ${GIT_EXECUTABLE} config --file ${PROJECT_SOURCE_DIR}/.gitmodules --get-regexp path
      WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
      OUTPUT_VARIABLE output
      OUTPUT_STRIP_TRAILING_WHITESPACE)

    string(REPLACE "\n" ";" output "${output}")

    foreach(arg IN LISTS output)
      string(REPLACE " " ";" arg "${arg}")
      list(GET arg -1 arg)
      set(path "${PROJECT_SOURCE_DIR}/${arg}")

      if (EXISTS ${path})
        get_filename_component(name ${path} NAME)

        list(APPEND submodules ${name})

        CMAKE_DEPENDENT_OPTION(
          ${name}.submodule
          "Use dependency submodule rather than system installations" ON
          "git.submodule.packages" OFF)

        if(git.submodule.packages AND ${${name}.submodule})
          set(${name}.submodule.path
            "${path}"
            CACHE PATH "Absolute path to ${name} git submodule")
        endif()
      endif()
    endforeach()
  endif()

  set(${CMAKE_PROJECT_NAME}.submodules
    ${submodules} CACHE INTERNAL
    "A CMake list of git submodules for ${CMAKE_PROJECT_NAME}")
endfunction()
