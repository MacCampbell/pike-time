#! /bin/bash

#needed numba on cluster and didn't feel like doing it.

cd outputs/102
ln -s 197.beagle.gz 197.beagle.Z
cd ../../

python ~/pcangsd/pcangsd.py -beagle ./outputs/102/197.beagle.Z -admix -o ./outputs/102/197

# admixture proportions are in .qopt
# covariance matrix is .cov
