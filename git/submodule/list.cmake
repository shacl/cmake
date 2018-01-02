get_property(
  git.submodule.list.cmake
  GLOBAL PROPERTY git.submodule.list.cmake SET)

if(NOT git.submodule.list.cmake)
  include(CMakeDependentOption)

  function(git_submodule_list)
    if(EXISTS "${PROJECT_SOURCE_DIR}/.gitmodules")
      execute_process(
        COMMAND ${GIT_EXECUTABLE} config --file ${PROJECT_SOURCE_DIR}/.gitmodules --get-regexp path
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        OUTPUT_VARIABLE output
        OUTPUT_STRIP_TRAILING_WHITESPACE)

      string(REPLACE " " ";" output ${output})

      foreach(entry IN LISTS output)
        set(path "${PROJECT_SOURCE_DIR}/${entry}")

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

            set(${name}.submodule.hash "" CACHE STRING
              "${name} git submodule hash")

            if(NOT ${name}.submodule.hash)
              set(${name}.submodule.branch ${git.submodule.default_branch}
                CACHE STRING "${name} git submodule branch")
            endif()
          endif()
        endif()
      endforeach()
    endif()

    set(${CMAKE_PROJECT_NAME}.submodules
      ${submodules} CACHE STRING
      "A CMake list of git submodules for ${CMAKE_PROJECT_NAME}")
  endfunction()

  set_property(GLOBAL PROPERTY git.submodule.list.cmake "")
endif()
