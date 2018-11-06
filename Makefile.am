bin_PROGRAMS = cogaps

cogaps_SOURCES = \
    src/CoGAPS.cpp \
    src/Rpackage/src/GapsParameters.cpp \
    src/Rpackage/src/GapsResult.cpp \
    src/Rpackage/src/GapsRunner.cpp \
    src/Rpackage/src/GapsStatistics.cpp \
    src/Rpackage/src/atomic/AtomAllocator.cpp \
    src/Rpackage/src/atomic/AtomicDomain.cpp \
    src/Rpackage/src/atomic/ProposalQueue.cpp \
    src/Rpackage/src/data_structures/HashSets.cpp \
    src/Rpackage/src/data_structures/HybridMatrix.cpp \
    src/Rpackage/src/data_structures/HybridVector.cpp \
    src/Rpackage/src/data_structures/Matrix.cpp \
    src/Rpackage/src/data_structures/SparseIterator.cpp \
    src/Rpackage/src/data_structures/SparseMatrix.cpp \
    src/Rpackage/src/data_structures/SparseVector.cpp \
    src/Rpackage/src/data_structures/Vector.cpp \
    src/Rpackage/src/file_parser/CsvParser.cpp \
    src/Rpackage/src/file_parser/GctParser.cpp \
    src/Rpackage/src/file_parser/FileParser.cpp \
    src/Rpackage/src/file_parser/TsvParser.cpp \
    src/Rpackage/src/file_parser/MtxParser.cpp \
    src/Rpackage/src/gibbs_sampler/DenseGibbsSampler.cpp \
    src/Rpackage/src/gibbs_sampler/SparseGibbsSampler.cpp \
    src/Rpackage/src/math/Math.cpp \
    src/Rpackage/src/math/MatrixMath.cpp \
    src/Rpackage/src/math/Random.cpp \
    src/Rpackage/src/math/VectorMath.cpp

cogaps_CPPFLAGS = @GAPS_CPP_FLAGS@
cogaps_CXXFLAGS = @GAPS_CXX_FLAGS@
cogaps_LDFLAGS = @GAPS_LDFLAGS@
cogaps_LDADD = @GAPS_LIBS@