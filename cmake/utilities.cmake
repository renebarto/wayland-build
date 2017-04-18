# Create directory
function(mkdir name)
    execute_process(COMMAND mkdir -pv ${name})
endfunction()

# Get archive
function(wget url workingdir)
    mkdir(${workingdir})
    execute_process(COMMAND wget ${url}
            WORKING_DIRECTORY ${workingdir})
endfunction()

# Extract tar
function(tar_extract archive directory workingdir)
    mkdir(${workingdir})
    execute_process(COMMAND tar xf ${archive} -C {directory}
            WORKING_DIRECTORY ${workingdir})
endfunction()

