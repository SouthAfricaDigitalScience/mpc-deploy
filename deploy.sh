#!/bin/bash -e
# this should be run after check-build finishes.
. /etc/profile.d/modules.sh
echo ${SOFT_DIR}
module add deploy
# Now, dependencies
module add gmp
module add mpfr
module add ncurses
echo ${SOFT_DIR}
cd ${WORKSPACE}/${NAME}-${VERSION}/build-${BUILD_NUMBER}
echo "All tests have passed, will now build into ${SOFT_DIR}"
rm -rf *
../configure \
--prefix ${SOFT_DIR} \
--with-mpfr=${MPFR_DIR} \
--with-gmp=${GMP_DIR}
make install
mkdir -p ${LIBRARIES_MODULES}/${NAME}

# Now, create the module file for deployment
(
cat <<MODULE_FILE
#%Module1.0
## $NAME modulefile
##
proc ModulesHelp { } {
    puts stderr "       This module does nothing but alert the user"
    puts stderr "       that the [module-info name] module is not available"
}
prereq mpfr
module-whatis   "$NAME $VERSION : See https://github.com/SouthAfricaDigitalScience/mpc-deploy"
setenv       MPC_VERSION       $VERSION
setenv       MPC_DIR           $::env(CVMFS_DIR)/$::env(SITE)/$::env(OS)/$::env(ARCH)/$NAME/$VERSION
prepend-path LD_LIBRARY_PATH   $::env(MPC_DIR)/lib
prepend-path GCC_INCLUDE_DIR   $::env(MPC_DIR)/include
MODULE_FILE
) > ${LIBRARIES_MODULES}/${NAME}/${VERSION}
