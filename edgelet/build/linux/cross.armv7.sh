#!/bin/bash

###############################################################################
# This script builds the project
###############################################################################

set -e

###############################################################################
# Define Environment Variables
###############################################################################
# Get directory of running script
DIR=$(cd "$(dirname "$0")" && pwd)

BUILD_REPOSITORY_LOCALPATH=${BUILD_REPOSITORY_LOCALPATH:-$DIR/../../..}
PROJECT_ROOT=${BUILD_REPOSITORY_LOCALPATH}/edgelet
SCRIPT_NAME=$(basename "$0")
TOOLCHAIN="armv7-unknown-linux-gnueabihf"
RELEASE=

###############################################################################
# Print usage information pertaining to this script and exit
###############################################################################
usage()
{
    echo "$SCRIPT_NAME [options]"
    echo ""
    echo "options"
    echo " -h, --help          Print this help and exit."
    echo " -t <toolchain>, --toolchain <toolchain>    Toolchain (default/notset: $TOOLCHAIN)"
    echo " -r, --release       Release build? (flag, default/notset: false)"
    exit 1;
}

###############################################################################
# Obtain and validate the options supported by this script
###############################################################################
process_args()
{
    save_next_arg=0
    for arg in "$@"
    do
        if [ $save_next_arg -eq 1 ]; then
            TOOLCHAIN="$arg"
            save_next_arg=0
        else
            case "$arg" in
                "-h" | "--help" ) usage;;
                "-t" | "--toolchain" ) save_next_arg=1;;
                "-r" | "--release" ) RELEASE="true";;
                * ) usage;;
            esac
        fi
    done
}

process_args "$@"

if [[ -z ${RELEASE} ]]; then
    echo "cross build --all --target $TOOLCHAIN"
    cd "$PROJECT_ROOT" && cross build --all --target "$TOOLCHAIN"
else
    echo "cross build --all --release --target $TOOLCHAIN"
    cd "$PROJECT_ROOT" && cross build --all --release --target "$TOOLCHAIN"
fi
