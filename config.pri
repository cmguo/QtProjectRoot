PRODUCT_CONFIG=$$(PRODUCT_CONFIG)
CONFIG += $$PRODUCT_CONFIG

OUTPUT_DIR=$$(OUTPUT_DIR)
isEmpty(OUTPUT_DIR) {
    CONFIG(release, debug|release): DESTDIR = $$OUT_PWD/../release
    CONFIG(debug, debug|release): DESTDIR = $$OUT_PWD/../debug
} else {
    CONFIG(release, debug|release): DESTDIR = $$OUTPUT_DIR/release
    CONFIG(debug, debug|release): DESTDIR = $$OUTPUT_DIR/debug
}

LIBS += -L$$DESTDIR

# special rules for visual studio
msvc: include($$PWD/msvc.pri)
