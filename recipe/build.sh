mkdir -p build
cd build

if [ $(uname) == Darwin ]; then
    export CFLAGS="${CFLAGS} -isysroot ${CONDA_BUILD_SYSROOT}"
    export CXXFLAGS="${CXXFLAGS} -stdlib=libc++ -isysroot ${CONDA_BUILD_SYSROOT}"
fi

export MPI_FLAGS="--allow-run-as-root"

if [ $(uname) == Linux ]; then
    export MPI_FLAGS="$MPI_FLAGS;-mca;plm;isolated"
fi

# TODO: Re-enable Tpetra, Zoltan2, Amesos2, Ifpack2, Teko, ShyLU, MueLu, Xpetra

cmake \
  -D CMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} \
  -D CMAKE_BUILD_TYPE:STRING=RELEASE \
  -D CMAKE_INSTALL_PREFIX:PATH=$PREFIX \
  -D BUILD_SHARED_LIBS:BOOL=ON \
  -D TPL_ENABLE_MPI:BOOL=ON \
  -D MPI_BASE_DIR:PATH=$PREFIX \
  -D MPI_EXEC:FILEPATH=$PREFIX/bin/mpiexec \
  -D PYTHON_EXECUTABLE:FILEPATH=$PYTHON \
  -D SWIG_EXECUTABLE:FILEPATH=$PREFIX/bin/swig \
  -D Trilinos_ENABLE_Fortran:BOOL=OFF \
  -D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
  -D Trilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=OFF \
  -D Trilinos_ENABLE_TESTS:BOOL=OFF \
  -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
  -D Trilinos_ENABLE_Doxygen:BOOL=OFF \
  -D Trilinos_ENABLE_Teuchos:BOOL=ON \
  -D Trilinos_ENABLE_RTOp:BOOL=ON \
  -D Trilinos_ENABLE_Sacado:BOOL=ON \
  -D Trilinos_ENABLE_MiniTensor:BOOL=ON \
  -D Trilinos_ENABLE_Epetra:BOOL=ON \
  -D Trilinos_ENABLE_Zoltan:BOOL=ON \
  -D Trilinos_ENABLE_Shards:BOOL=ON \
  -D Trilinos_ENABLE_GlobiPack:BOOL=ON \
  -D Trilinos_ENABLE_Triutils:BOOL=ON \
  -D Trilinos_ENABLE_Tpetra:BOOL=OFF \
  -D Trilinos_ENABLE_EpetraExt:BOOL=ON \
  -D Trilinos_ENABLE_Domi:BOOL=OFF \
  -D Trilinos_ENABLE_Thyra:BOOL=ON \
  -D Trilinos_ENABLE_Xpetra:BOOL=OFF \
  -D Trilinos_ENABLE_OptiPack:BOOL=ON \
  -D Trilinos_ENABLE_Isorropia:BOOL=OFF \
  -D Trilinos_ENABLE_Pliris:BOOL=ON \
  -D Trilinos_ENABLE_AztecOO:BOOL=ON \
  -D Trilinos_ENABLE_Galeri:BOOL=ON \
  -D Trilinos_ENABLE_Amesos:BOOL=ON \
  -D Trilinos_ENABLE_Pamgen:BOOL=ON \
  -D Trilinos_ENABLE_Zoltan2:BOOL=OFF \
  -D Trilinos_ENABLE_Ifpack:BOOL=ON \
  -D Trilinos_ENABLE_ML:BOOL=ON \
  -D Trilinos_ENABLE_Belos:BOOL=ON \
  -D Trilinos_ENABLE_ShyLU:BOOL=OFF \
  -D Trilinos_ENABLE_Amesos2:BOOL=OFF \
  -D Trilinos_ENABLE_SEACAS:BOOL=OFF \
  -D Trilinos_ENABLE_Komplex:BOOL=ON \
  -D Trilinos_ENABLE_Anasazi:BOOL=ON \
  -D Trilinos_ENABLE_Ifpack2:BOOL=OFF \
  -D Ifpack2_ENABLE_TESTS:BOOL=OFF \
  -D Trilinos_ENABLE_Stratimikos:BOOL=ON \
  -D Trilinos_ENABLE_FEI:BOOL=ON \
  -D Trilinos_ENABLE_Teko:BOOL=OFF \
  -D Trilinos_ENABLE_Intrepid:BOOL=ON \
  -D Trilinos_ENABLE_STK:BOOL=OFF \
  -D Trilinos_ENABLE_Phalanx:BOOL=ON \
  -D Trilinos_ENABLE_NOX:BOOL=OFF \
  -D NOX_ENABLE_LOCA:BOOL=OFF \
  -D Trilinos_ENABLE_MueLu:BOOL=OFF \
  -D Trilinos_ENABLE_Rythmos:BOOL=ON \
  -D Trilinos_ENABLE_Stokhos:BOOL=ON \
  -D Trilinos_ENABLE_ROL:BOOL=ON \
  -D Trilinos_ENABLE_Piro:BOOL=OFF \
  -D Trilinos_ENABLE_TrilinosCouplings:BOOL=ON \
  -D Trilinos_ENABLE_Pike:BOOL=ON \
  -D Trilinos_ENABLE_PyTrilinos:BOOL=ON \
  -D PyTrilinos_ENABLE_TESTS:BOOL=ON \
  -D PyTrilinos_ENABLE_EXAMPLES:BOOL=ON \
  -D PyTrilinos_INSTALL_PREFIX:PATH=$PREFIX \
  -D PyTrilinos_ENABLE_NOX:BOOL=OFF \
  -D PyTrilinos_ENABLE_Domi:BOOL=OFF \
  $SRC_DIR

make -j $CPU_COUNT install
