isEmpty(DESTDIR) {
    CONFIG(release, debug|release): DESTDIR = $$OUT_PWD/../release
    CONFIG(debug, debug|release): DESTDIR = $$OUT_PWD/../debug
}

LIBS += -L$$DESTDIR

# special rules for visual studio
msvc: include($$PWD/msvc.pri)
