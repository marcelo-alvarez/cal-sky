#----------------------------------------------------------------------
# OPTIONS FOR RUNNING ON SCINET-GPC MACHINES
#----------------------------------------------------------------------

OPTIMIZE =  -O4 -w 

MODFLAG = -module 
OMPLIB = -openmp

FFTW2_PATH = $(HOME)/fftw-2.1.5/
CFITS_PATH = $(HOME)/cfitsio/
GSL_PATH = $(HOME)/gsl-2.4/

CC = mpicc
C++ = mpic++

OPTIONS = -w 

#----------------------------------------------------------------------
# DO NOT MODIFY THIS FILE
#----------------------------------------------------------------------

FFTLIB = -L$(FFTW2_PATH)/lib -lsrfftw_mpi -lsfftw_mpi -lsrfftw -lsfftw
FFTINC = -I$(FFTW2_PATH)/include 

#FFTLIB = -L$(FFTW2_PATH)/lib -L$(FFTW3_PATH)/lib -lsrfftw_mpi -lsfftw_mpi -lsrfftw -lsfftw
#FFTINC = -I$(FFTW2_PATH)/include -I$(FFTW3_PATH)/include 

CFTLIB = -L$(CFITS_PATH)/lib -lcfitsio
CFTINC = -I$(CFITS_PATH)/include

GSLLIB = -L$(GSL_PATH)/lib -lgsl -lgslcblas
GSLINC = -I$(GSL_PATH)/include

LIB = $FFTLIB $CFTLIB $GSLLIB
INC = $FFTINC $CFTINC $GSLINC
 
# OBJECT FILES
srcdir  = ./src
objs = \
     $(srcdir)/allocate.o \
     $(srcdir)/allvars.o \
     $(srcdir)/commandline.o \
     $(srcdir)/lpt.o \
     $(srcdir)/geometry.o \
     $(srcdir)/main.o \
     $(srcdir)/makemaps.o \
     $(srcdir)/parallel_io.o \
     $(srcdir)/io.o \
     $(srcdir)/chealpix.o \
     $(srcdir)/arrayoperations.o \
     $(srcdir)/cosmology.o \
     $(srcdir)/math.o \
     $(srcdir)/memorytracking.o \
     $(srcdir)/tables.o 

bindir = ./bin

COMPILE_FLAGS = $(OPTIMIZE) $(FFTINC) $(GSLINC) $(CFTINC) -DENABLE_FITSIO
LINK_FLAGS    = $(OPTIMIZE) $(FFTLIB) $(GSLLIB) $(CFTLIB)

EXEC = lin2map

OBJS     = $(objs)

.SUFFIXES: .o .f .f90 .F90 .c .C

$(srcdir)/%.o: $(srcdir)/%.c
	$(CC)  $(COMPILE_FLAGS) -c $< -o $@
$(srcdir)/%.o: $(srcdir)/%.C 
	$(C++) $(COMPILE_FLAGS) -c $< -o $@

$(EXEC): $(OBJS) 
	$(C++) $(OBJS) $(LINK_FLAGS) -o  $(bindir)/$(EXEC)  

clean:
	rm -f $(EXEC) $(OBJS) 


