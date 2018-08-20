#!/bin/bash

set -ex


main() {
    local imagename=azureiotedge_crossbuilder
    local target=armv7
    local hostplatform=x86_64
    local triple=arm-linux-gnueabihf
    local mainver=7.3-2018.05
    local version=7.3.1-2018.05
    local build_tools=gcc-linaro-${version}-${hostplatform}_${triple}

    if [[ ! -f Dockerfile.${target} ]]
    then
        echo "Expected Dockerfile in current directory."
        return 1
    fi

    if [[ ! -d  ${build_tools} ]]
    then
        # extract Linaro toolchain 
        curl -L -o ${build_tools}.tar.xz https://releases.linaro.org/components/toolchain/binaries/${mainver}/${triple}/${build_tools}.tar.xz 
        xzcat ${build_tools}.tar.xz | \
            tar -xvf -
    
        rm ${build_tools}.tar.xz
    fi

    # Once toolchain is downloaded and extracted, build docker image with toolchain
    docker build --build-arg TOOLCHAIN=${build_tools} --tag ${imagename}:${build_tools} -f ./Dockerfile.${target} .

    # cleanup
    rm -fr ${build_tools}
}

main "${@}"
