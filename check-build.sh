#!/bin/bash
# Copyright 2016 C.S.I.R Meraka Institute
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. /etc/profile.d/modules.sh
module add ci
module add gmp
case  ${VERSION:2:1} in
    0) module add mpfr/3.1.2 ;;
    1) module add mpfr/4.0.1 ;;
    *) echo "Sorry, you have a wierd MPC version : $VERSION" ;;
esac
module add ncurses

cd ${WORKSPACE}/${NAME}-${VERSION}/build-${BUILD_NUMBER}

make check

make install # this will install to /apprepo
mkdir -p modules
(
cat <<MODULE_FILE
#%Module1.0
## $NAME modulefile
##
proc ModulesHelp { } {
puts stderr " This module does nothing but alert the user"
puts stderr " that the [module-info name] module is not available"
}
module-whatis "$NAME $VERSION."
setenv MPC_VERSION $VERSION
setenv MPC_DIR /data/ci-build/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION
prepend-path LD_LIBRARY_PATH $::env(MPC_DIR)/lib
prepend-path GCC_INCLUDE_DIR $::env(MPC_DIR)/lib
MODULE_FILE
) > modules/${VERSION}
mkdir -p ${LIBRARIES}/${NAME}
cp modules/${VERSION} ${LIBRARIES}/${NAME}

#  Use the module

module avail ${NAME}

module add ${NAME}/${VERSION}
