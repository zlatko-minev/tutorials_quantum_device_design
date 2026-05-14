#!/bin/bash

# This script will:
# 1. Install Spack in the current directory
# 2. Install MPI via Spack
# 3. Set the system MPI to Spack's MPI
# 4. Clone the Palace repository
# 5. Build Palace

spack_repo="https://github.com/spack/spack.git"
palace_repo="https://github.com/awslabs/palace.git"



#install uv 
curl -LsSf https://astral.sh/uv/install.sh | sh
git clone https://github.com/LFL-Lab/SQuADDS.git
cd SQuADDS
uv sync
uv run python -c "import squadds; print(squadds.__file__)"
cd ..

uv pip install quantum_metal


git clone https://github.com/sqdlab/SQDMetal.git
cd SQDMetal
pip install .
cd ..


# Update and upgrade packages
sudo apt-get update
sudo apt-get upgrade

# Install utilities
sudo apt-get install gmsh paraview -y

# Install Spack prerequisites
sudo apt-get install build-essential ca-certificates coreutils curl environment-modules gfortran git gpg lsb-release python3 python3-distutils python3-venv unzip zip -y

# Install Palace prerequisites
sudo apt-get install pkg-config build-essential cmake python3 mpi-default-dev -y

sudo apt update && sudo apt install software-properties-common lsb-release wget -y
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add - -y
# Get the Ubuntu release code name (e.g., 'focal', 'jammy')
export CODE_NAME=$(lsb_release -sc)

# Add the repository line
sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $CODE_NAME main" -y
sudo apt update
sudo apt install cmake -y
cmake --version

# Install Spack
echo 'Installing Spack to:'
echo $spack_install_dir
git clone -c feature.manyFiles=true $spack_repo
. spack/share/spack/setup-env.sh

# Install MPI
echo 'Installing MPI'
spack install mpi

mpi_info=($(spack find -p mpi))
mpi_dir=${mpi_info[-1]}
mpi_bin_dir="$mpi_dir/bin"

# Set up paths
echo 'MPI bin directory:'
echo $mpi_bin_dir
echo -n 'export PATH="' > setup_palace_env.sh
echo -n $mpi_bin_dir >> setup_palace_env.sh
echo ':$PATH"' >> setup_palace_env.sh
source setup_palace_env.sh

# Install Palace
echo 'Installing Palace to:'
echo $palace_install_dir
git clone --recurse-submodules $palace_repo
cd palace
mkdir build
cd build
cmake ..
make -j