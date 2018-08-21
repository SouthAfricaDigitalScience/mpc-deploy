[![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=mpc-deploy)](https://ci.sagrid.ac.za/job/mpc-deploy)

# mpc-deploy

Build, test and deployment scripts for [GNU multiprecision library](http://www.multiprecision.org/index.php?prog=mpc) for CODE-RADE

# Dependencies

This project has the following dependencies :

  * [mpfr](http://www.mpfr.org/) - [![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=mpfr-deploy)](https://ci.sagrid.ac.za/job/mpfr-deploy)
  * [gmp](https://gmplib.org/) - [![Build Status](https://ci.sagrid.ac.za/buildStatus/icon?job=gmp-deploy)](https://ci.sagrid.ac.za/job/gmp-deploy)

Note: 

MPC 1.1.x requires MPFR 4.x while MPC 1.0.x requires MPFR 3.x

# Versions

We build the following versions :
  
  * 1.1.1
  * 1.0.3 
  * 1.0.2
  * 1.0.1

# Configuration

The project is built with the following configuration :

```
../configure \
--prefix=${SOFT_DIR} \
--with-mpfr=${MPFR_DIR} \
--with-gmp=${GMP_DIR}
--enable-static \
--enable-shared
```

# Citing

Cite as

Bruce Becker. (2017). SouthAfricaDigitalScience/mpc-deploy: CODE-RADE Foundation Release 3 : MPC [Data set]. Zenodo. http://doi.org/10.5281/zenodo.254219 [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.254219.svg)](https://doi.org/10.5281/zenodo.254219)
