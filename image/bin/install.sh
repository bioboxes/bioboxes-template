#!/bin/bash

# Exit this script if any errors are encountered
set -o errexit

# Exit this script if any unset bash variables are used
set -o nounset

# Provide verbose logging of installation with interpolated variables
set -o xtrace


# APT packages that are required to build and compile your software, but are not
# required for running the software. Examples of this might be g++ or python-pip.
# These are installed before running the build scripts, then purged after the build
# process is complete.
NON_ESSENTIAL_BUILD=""

# Packages that required to build the software, and are also required when running
# the software.
ESSENTIAL_BUILD=""

# Packages that are not required to build or compile the software but are required
# to run the software. Examples of these might be python-minimal or
# openjdk-7-jre-headless
RUNTIME=""

# Install essential and non essential build packages
apt-get update --yes
apt-get install --yes --no-install-recommends ${NON_ESSENTIAL_BUILD} ${ESSENTIAL_BUILD}




# The code to install the required software should go here




# Remove and purge all software that was used to build the package
apt-get autoremove --purge --yes ${NON_ESSENTIAL_BUILD}

# Ensure all required runtime packages are installed
apt-get install --yes --no-install-recommends ${ESSENTIAL_BUILD} ${RUNTIME}


# Clean up any no longer needed apt-files
apt-get clean
rm -rf /var/lib/apt/lists/* ${TMP}/*

# Remove all no-longer-required build artefacts
EXTENSIONS=("pyc" "c" "cc" "cpp" "h" "o")
for EXT in "${EXTENSIONS[@]}"
do
	find /usr/local -name "*.$EXT" -delete
done

# Please consider removing any other build artefacts or test data from the installed
# packages to reduce the overall size of the docker image
