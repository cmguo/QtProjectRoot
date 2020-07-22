PRODUCT_CONFIG=$$(PRODUCT_CONFIG)
PRODUCT_CONFIG=prod_xkt
#PRODUCT_CONFIG=prod_qxkt

CONFIG += $$PRODUCT_CONFIG

OUTPUT_DIR=$$(OUTPUT_DIR)
isEmpty(OUTPUT_DIR) {
    CONFIG(release, debug|release): DESTDIR = $$OUT_PWD/../release
    CONFIG(debug, debug|release): DESTDIR = $$OUT_PWD/../debug
} else {
    CONFIG(release, debug|release): DESTDIR = $$OUTPUT_DIR/release
    CONFIG(debug, debug|release): DESTDIR = $$OUTPUT_DIR/debug
}

CONFIG(prod_xkt, prod_xkt|prod_qxkt) {
    DEFINES += ENABLE_PRAISE
}

CONFIG(prod_qxkt, prod_xkt|prod_qxkt) {
    DEFINES += ENABLE_TICKET_REFRESH
}


LIBS += -L$$DESTDIR

# special rules for visual studio
msvc: include($$PWD/msvc.pri)
