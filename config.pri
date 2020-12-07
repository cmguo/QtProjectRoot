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
LIBS += -L$$DESTDIR

plugin: {
    DESTDIR = $$DESTDIR/plugins/components
}

include($$PWD/platforms/platforms.pri)
include($$PWD/products/products.pri)
