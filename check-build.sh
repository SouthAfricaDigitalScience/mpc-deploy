#!/bin/bash
. /etc/profile.d/modules.sh
module add ci
module add gmp
module add mpfr
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
setenv MPC_DIR $::env(SOFT_DIR)
prepend-path LD_LIBRARY_PATH $::env(MPC_DIR)/lib
prepend-path GCC_INCLUDE_DIR $::env(MPC_DIR)/lib
MODULE_FILE
) > modules/${VERSION}
mkdir -p ${LIBRARIES_MODULES}/${NAME}
cp modules/${VERSION} ${LIBRARIES_MODULES}/${NAME}
