# lpt-lc

I) Install & Compile

1. create a new copy of the file Make.mach.generic and rename to your machine:
    cp Make.mach.generic Make.mach.\<your-machine\>
2. edit the file Make.mach.\<your-machine\> to reflect your libraries and C/C++ compiler flags (you need to have mpi, gsl, fftw-2.1.5, and cfitsio installed)
2. run configure (which just concatenates two files to make the Makefile):
    ./configure \<your-machine\>
3. compile:
    make

II) Test

1. go to the test directory and run the test:
   cd test
   ./run_test.sh
   


