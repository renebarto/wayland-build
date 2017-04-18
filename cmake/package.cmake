# Download package
function(download_package name version format site)
    set(base ${name}-${version})
    message(STATUS "Downloading package ${base}")
    mkdir(${PACKAGE_DOWNLOAD_DIR})
    wget(${site}/${base}.${format} ${PACKAGE_DOWNLOAD_DIR})
endfunction()

# Extract package
function(extract_package name version format)
    set(base ${name}-${version})
    set(archive ${base}.${format})
    tar_extract(${archive} ${PACKAGE_BUILD_DIR}/${base})
endfunction()

# Configure package
function(configure_package name)
endfunction()

# Build package
function(build_package name)
endfunction()

# Install package
function(install_package name)
endfunction()
