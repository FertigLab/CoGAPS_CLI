bin_PROGRAMS = cogaps

cogaps_SOURCES = \
    src/CoGAPS.cpp \
    src/Rpackage/src/AtomicDomain.cpp \
    src/Rpackage/src/GapsDispatcher.cpp \
    src/Rpackage/src/GapsRunner.cpp \
    src/Rpackage/src/GapsStatistics.cpp \
    src/Rpackage/src/GibbsSampler.cpp \
    src/Rpackage/src/ProposalQueue.cpp \
    src/Rpackage/src/data_structures/Matrix.cpp \
    src/Rpackage/src/data_structures/Vector.cpp \
    src/Rpackage/src/file_parser/CsvParser.cpp \
    src/Rpackage/src/file_parser/FileParser.cpp \
    src/Rpackage/src/file_parser/TsvParser.cpp \
    src/Rpackage/src/file_parser/MtxParser.cpp \
    src/Rpackage/src/math/Algorithms.cpp \
    src/Rpackage/src/math/Random.cpp

cogaps_CPPFLAGS = @BOOST_CPPFLAGS@
cogaps_CXXFLAGS = -msse4.2
cogaps_LDFLAGS = @BOOST_LDFLAGS@
cogaps_LDADD = @BOOST_PROGRAM_OPTIONS_LIB@