# install MKL

# set path
# on aws
export MKLROOT=/home/ubuntu/intel/mkl
# on g5500
export MKLROOT=/opt/intel/mkl
export CUDADIR=/usr/local/cuda
export LD_LIBRARY_PATH=${MKLROOT}/lib/intel64_lin:$LD_LIBRARY_PATH

cp make.inc-examples/make.inc.mkl-gcc-ilp64 make.inc
make lib -j
cd testing
make testing_dxgesv_gpu

# on aws only 4 cpu
export OMP_NUM_THREADS=4
export OMP_NUM_THREADS=28
# or 14 to get a similar result
# or 56 with worse result

# 2019/12/12/2100: I modify make.inc-examples/make.inc.mkl-gcc-ilp64 to use volta architecture, but still 
# 30016     1   1928.00    1925.67   8795.94    8761.52   7563.47               2   4.56e-19   ok

# to testing only the fp64
# numactl --interleave=all ./testing_dgesv_gpu -N 30016 --matrix diag_rand
# 30016     1     ---   (  ---  )   1908.82 (   9.45)   3.70e-21   ok
# still very low at fp64

numactl --interleave=all ./testing_dxgesv_gpu -N 30016 --matrix diag_rand --version 3


# on aws with omp 4 and mkl
ubuntu@ip-172-31-46-17:~/mgm251/testing$ numactl --interleave=all ./testing_dxgesv_gpu -N 30016 --matrix diag_rand --version 3
% MAGMA 2.5.1  compiled for CUDA capability >= 3.0, 64-bit magma_int_t, 64-bit pointer.
% CUDA runtime 10000, driver 10010. OpenMP threads 4. MKL 2019.0.5, MKL threads 4. 
% device 0: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% Fri Dec 13 15:05:08 2019
% Epsilon(double): 1.110223e-16
% Epsilon(single): 5.960464e-08

% Usage: ./testing_dxgesv_gpu [options] [-h|--help]

ntest 1
niter 1
cond 0.000000
msize 30016
% trans = No transpose
%   N  NRHS   DP-Factor  DP-Solve  HP-Factor  HP-Solve  MP: FP16->FP64-Solve  Iter   |b-Ax|/N|A|
%=========================================================================================
itest 0
iter 0
N 30016
30016     1   3834.59    3826.24   8887.43    8856.35   8814.68               2   4.56e-19   ok


# aws with omp 8 but still 4 cores
ubuntu@ip-172-31-46-17:~/mgm251/testing$ numactl --interleave=all ./testing_dxgesv_gpu -N 30016 --matrix diag_rand --version 3
% MAGMA 2.5.1  compiled for CUDA capability >= 3.0, 64-bit magma_int_t, 64-bit pointer.
% CUDA runtime 10000, driver 10010. OpenMP threads 8. MKL 2019.0.5, MKL threads 4. 
% device 0: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% Fri Dec 13 15:12:15 2019
% Epsilon(double): 1.110223e-16
% Epsilon(single): 5.960464e-08

% Usage: ./testing_dxgesv_gpu [options] [-h|--help]

ntest 1
niter 1
cond 0.000000
msize 30016
% trans = No transpose
%   N  NRHS   DP-Factor  DP-Solve  HP-Factor  HP-Solve  MP: FP16->FP64-Solve  Iter   |b-Ax|/N|A|
%=========================================================================================
itest 0
iter 0
N 30016
30016     1   3830.85    3822.45   9160.90    9128.03   8815.17               2   4.56e-19   ok

# aws 4 core fp64
ubuntu@ip-172-31-46-17:~/mgm251/testing$ numactl --interleave=all  ./testing_dgesv_gpu -N 30016 --matrix  diag_rand
% MAGMA 2.5.1  compiled for CUDA capability >= 3.0, 64-bit magma_int_t, 64-bit pointer.
% CUDA runtime 10000, driver 10010. OpenMP threads 4. MKL 2019.0.5, MKL threads 4. 
% device 0: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% Fri Dec 13 15:19:55 2019
% Usage: ./testing_dgesv_gpu [options] [-h|--help]

%   N  NRHS   CPU Gflop/s (sec)   GPU Gflop/s (sec)   ||B - AX|| / N*||A||*||X||
%===============================================================================
30016     1     ---   (  ---  )   3588.67 (   5.02)   3.70e-21   ok


# aws 4 gpu 16 core 
ubuntu@ip-172-31-46-17:~/mgm251/testing$ export OMP_NUM_THREADS=16
ubuntu@ip-172-31-46-17:~/mgm251/testing$ numactl --interleave=all ./testing_dxgesv_gpu -N 30016 --matrix diag_rand --version 3
% MAGMA 2.5.1  compiled for CUDA capability >= 3.0, 64-bit magma_int_t, 64-bit pointer.
% CUDA runtime 10000, driver 10010. OpenMP threads 16. MKL 2019.0.5, MKL threads 16. 
% device 0: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% device 1: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% device 2: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% device 3: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% Fri Dec 13 15:30:36 2019
% Epsilon(double): 1.110223e-16
% Epsilon(single): 5.960464e-08

% Usage: ./testing_dxgesv_gpu [options] [-h|--help]

ntest 1
niter 1
cond 0.000000
msize 30016
% trans = No transpose
%   N  NRHS   DP-Factor  DP-Solve  HP-Factor  HP-Solve  MP: FP16->FP64-Solve  Iter   |b-Ax|/N|A|
%=========================================================================================
itest 0
iter 0
N 30016
30016     1   6173.57    6151.40   18206.42    18075.53   16462.07               2   4.56e-19   ok


ubuntu@ip-172-31-46-17:~/mgm251/testing$ numactl --interleave=all ./testing_dgesv_gpu -N 30016 --matrix diag_rand
% MAGMA 2.5.1  compiled for CUDA capability >= 3.0, 64-bit magma_int_t, 64-bit pointer.
% CUDA runtime 10000, driver 10010. OpenMP threads 16. MKL 2019.0.5, MKL threads 16. 
% device 0: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% device 1: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% device 2: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% device 3: Tesla V100-SXM2-16GB, 1530.0 MHz clock, 16130.5 MiB memory, capability 7.0
% Fri Dec 13 15:38:02 2019
% Usage: ./testing_dgesv_gpu [options] [-h|--help]

%   N  NRHS   CPU Gflop/s (sec)   GPU Gflop/s (sec)   ||B - AX|| / N*||A||*||X||
%===============================================================================
30016     1     ---   (  ---  )   6341.32 (   2.84)   3.70e-21   ok



rm -f log
touch log
for i in 1000 2000 4000 8000 16000 32000 ; do
  # poev positive eigen value, seems very difficault to generate, at rank 30000 orso it cost 4000seconds
  # dsgesv have total nothong to do with tensor core
  numactl --interleave=all ./build/testing/testing_dsgesv_gpu -N $i --matrix poev_arith --cond 100 --version 3 >> log
done
