include_guard(GLOBAL)
function(get_git_info_for_directory source_dir return_url return_hash return_branch)

  # Get remote url of origin
  execute_process( COMMAND "${GIT_EXECUTABLE}" config --get remote.origin.url
                           WORKING_DIRECTORY "${source_dir}"
                           OUTPUT_STRIP_TRAILING_WHITESPACE
                           RESULT_VARIABLE rc
                           OUTPUT_VARIABLE output
                           ERROR_VARIABLE error )

  if( rc )
    string(CONCAT error_output
          "Error encountered while obtaining repository url for fetched content in ${source_dir} \n"
          "${output}"
          "${error}"
    )
    message(FATAL_ERROR "${error_output}")
  endif()

  set(${return_url} ${output} PARENT_SCOPE)

  # Get hash of current branch
  execute_process( COMMAND  "${GIT_EXECUTABLE}" rev-parse HEAD
                           WORKING_DIRECTORY "${source_dir}"
                           OUTPUT_STRIP_TRAILING_WHITESPACE
                           RESULT_VARIABLE rc
                           OUTPUT_VARIABLE output
                           ERROR_VARIABLE error )

  if( rc )
    string(CONCAT error_output
          "Error encountered while obtaining repository url for fetched content in ${source_dir} \n"
          "${output}"
          "${error}"
    )
    message(FATAL_ERROR "${error_output}")
  endif()

  set(${return_hash} ${output} PARENT_SCOPE)

  # Determine the branch or tag that was checked out.
  # FetchContent checks out tags/commits in a detached HEAD state,
  # To report the tag, first try to resolve a symbolic branch name,
  # if that fails (detached HEAD), fall back to the exact tag pointing at HEAD.

  # Try to get a symbolic branch name (empty/non-zero rc when detached)
  execute_process( COMMAND  "${GIT_EXECUTABLE}" symbolic-ref --short -q HEAD
                           WORKING_DIRECTORY "${source_dir}"
                           OUTPUT_STRIP_TRAILING_WHITESPACE
                           RESULT_VARIABLE rc
                           OUTPUT_VARIABLE output
                           ERROR_VARIABLE error )

  if( rc OR "${output}" STREQUAL "" )
    # Detached HEAD - try to find an exact tag pointing at HEAD
    execute_process( COMMAND  "${GIT_EXECUTABLE}" describe --tags --exact-match HEAD
                             WORKING_DIRECTORY "${source_dir}"
                             OUTPUT_STRIP_TRAILING_WHITESPACE
                             RESULT_VARIABLE rc
                             OUTPUT_VARIABLE output
                             ERROR_VARIABLE error )

    if( rc OR "${output}" STREQUAL "" )
      # Not an exact tag either - report HEAD
      set(output "HEAD")
    endif()
  endif()

  set(${return_branch} ${output} PARENT_SCOPE)

endfunction()

