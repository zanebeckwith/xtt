#!/bin/bash
# Copyright 2020 Xaptum, Inc.
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
        echo "usage: $0 <source-download-target> <install-target>"
        exit 1
fi

repo_url=https://github.com/tpm2-software/tpm2-tss
tag=2.3.3
source_dir="$1"
install_dir="$2"

rm -rf "${source_dir}"
git clone -b $tag "${repo_url}" "${source_dir}"

pushd "${source_dir}"

wget http://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2019.01.06.tar.xz
tar -xf autoconf-archive-2019.01.06.tar.xz
cp autoconf-archive-2019.01.06/m4/ax_code_coverage.m4 m4/
cp autoconf-archive-2019.01.06/m4/ax_prog_doxygen.m4 m4/
cp autoconf-archive-2019.01.06/m4/ax_is_release.m4 m4/

./bootstrap
./configure --prefix=${install_dir} --disable-esapi --disable-doxygen-doc --enable-fapi=no --enable-tcti-partial-reads=no
make -j $(nproc)
make install

popd
