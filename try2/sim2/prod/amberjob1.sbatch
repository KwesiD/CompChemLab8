#!/bin/bash

#SBATCH --job-name=Amber
#SBATCH --nodes=3
#SBATCH --tasks-per-node=28
#SBATCH --time=24:00:00
#SBATCH --mem=100GB


#Comments start here, above are not comments and should be in your script 
# go to your working directory: /scratch/kfd233/CompChemLab8/try2/sim2/prod.
cd /scratch/kfd233/CompChemLab8/try2/sim2/prod

# load module to run amber

module purge
module load amber/openmpi/intel/16.06 

# run heating job
mpiexec pmemd.MPI -O -i heat.in -o heat.out -p 2dvq_sol.prmtop -c min_all.rst -r heat.rst -x heat.mdcrd -ref min_all.rst

# run density job
mpiexec pmemd.MPI -O -i density.in -o density.out -p 2dvq_sol.prmtop   -c heat.rst -r density.rst -x density.mdcrd -ref min_all.rst

# run equil job
mpiexec pmemd.MPI -O -i equil.in -o equil.out -p 2dvq_sol.prmtop -c density.rst -r equil.rst -x equil.mdcrd -ref min_all.rst

