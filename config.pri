isEmpty(DESTDIR) {
    CONFIG(release, debug|release): DESTDIR = $$OUT_PWD/../release
    CONFIG(debug, debug|release): DESTDIR = $$OUT_PWD/../debug
}

LIBS += -L$$DESTDIR
win32: QMAKE_CXXFLAGS += /utf-8

CONFIG(debug, debug|release) {
    win32: TARGET = $$join(TARGET,,,d)
}

msvc:CONFIG(release, debug|release) {
    QMAKE_CXXFLAGS+=/Zi
    QMAKE_LFLAGS+= /INCREMENTAL:NO /Debug
    target2.files = $$OUT_PWD/release/$$TARGET.pdb
    target2.path = $$[QT_INSTALL_LIBS]
    INSTALLS += target2
}

# special rules for visual studio
win32: include($$PWD/vsconfig.pri)
