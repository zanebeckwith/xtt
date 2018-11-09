#!/bin/bash
# Copyright 2017 Xaptum, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License

set -e

if [[ $# -ne 2 ]]; then
        echo "usage: $0 <version> <absolute-path-to-libsodium-source-directory>"
        exit 1
fi

source_tag="$1"
source_dir="$2"
mkdir -p ${source_dir}
pushd ${source_dir}
wget https://download.libsodium.org/libsodium/releases/old/unsupported/libsodium-${source_tag}.tar.gz
tar xvfz libsodium-${source_tag}.tar.gz
pushd libsodium-${source_tag}
./configure --prefix=${INSTALL_PREFIX}
make
make install
popd
popd
