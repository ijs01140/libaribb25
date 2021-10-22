set(MANIFEST "${CMAKE_CURRENT_BINARY_DIR}/install_manifest.txt")

if(NOT EXISTS ${MANIFEST})
	message(FATAL_ERROR "Cannot find install manifest: '${MANIFEST}'")
endif()

file(STRINGS ${MANIFEST} files)
foreach(file ${files})
	if(EXISTS ${file} OR IS_SYMLINK ${file})
		message(STATUS "Removing file: '${file}'")

		exec_program(
			${CMAKE_COMMAND} ARGS "-E remove ${file}"
			OUTPUT_VARIABLE stdout
			RETURN_VALUE result
		)

		if(NOT "${result}" STREQUAL 0)
			message(FATAL_ERROR "Failed to remove file: '${file}'.")
		endif()
	else()
		message(STATUS "File '${file}' does not exist.")
	endif()
endforeach(file)
