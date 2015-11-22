#!/bin/bash -e
. /etc/profile.d/modules.sh
SOURCE_FILE=$NAME-$VERSION.tar.gz

module load ci
module add gmp
module add mpfr
module add ncurses
module list


echo "REPO_DIR is "
echo $REPO_DIR
echo "SRC_DIR is "
echo $SRC_DIR
echo "WORKSPACE is "
echo $WORKSPACE
echo "SOFT_DIR is"
echo $SOFT_DIR

echo $LD_LIBRARY_PATH

mkdir -p $WORKSPACE
mkdir -p $SRC_DIR
mkdir -p $SOFT_DIR

#  Download the source file

if [[ ! -s $SRC_DIR/$SOURCE_FILE ]] ; then
  echo "seems like this is the first build - let's get the source"
  mkdir -p $SRC_DIR
  wget http://mirror.ufs.ac.za/gnu/gnu/$NAME/$SOURCE_FILE -O $SRC_DIR/$SOURCE_FILE
  tar xvf $SRC_DIR/$SOURCE_FILE -C $WORKSPACE
else
  echo "continuing from previous builds, using source at " $SRC_DIR/$SOURCE_FILE
  tar xvzf $SRC_DIR/$SOURCE_FILE -C $WORKSPACE
fi
cd $WORKSPACE/$NAME-$VERSION
# We could probably loop through the dependencies here
./configure --prefix $SOFT_DIR --with-ncurses=$ncurses_DIR --with-mpfr=$MPFR_DIR  --with-gmp=${GMP_DIR}
make -j 8
