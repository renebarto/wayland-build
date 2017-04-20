# Create directory
function(mkdir name)
    execute_process(COMMAND mkdir -pv ${name})
endfunction()

# do_install
# A direct install script, copying files directly
function(do_install source destination)
    add_custom_target(install_${source}_${destination}
        COMMAND ${CMAKE_COMMAND} -E copy ${source} ${destination}
        COMMENT "Creating directories"
        VERBATIM)
endfunction()

