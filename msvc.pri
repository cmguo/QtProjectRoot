QMAKE_CXXFLAGS += /utf-8

CONFIG(debug, debug|release) {
    TARGET = $$join(TARGET,,,d)
}

CONFIG(release, debug|release) {
    QMAKE_CXXFLAGS+=/Zi
    QMAKE_LFLAGS+= /INCREMENTAL:NO /Debug
    target2.files = $$OUT_PWD/release/$$TARGET.pdb
    target2.path = $$[QT_INSTALL_LIBS]
    INSTALLS += target2
}
