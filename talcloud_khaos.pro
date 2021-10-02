message("Starting building process of project ...")
message("List the enviroment of .pro file of root object")
message(Qt version: $$[QT_VERSION])
message(Qt is installed in QT_INSTALL_PREFIX: $$[QT_INSTALL_PREFIX])
message(Qt resources can be found in the following locations:)
message(Documentation QT_INSTALL_DOCS: $$[QT_INSTALL_DOCS])
message(Header files QT_INSTALL_HEADERS: $$[QT_INSTALL_HEADERS])
message(Libraries QT_INSTALL_LIBS: $$[QT_INSTALL_LIBS])
message(Binary files (executables) QT_INSTALL_BINS: $$[QT_INSTALL_BINS])
message(Plugins QT_INSTALL_PLUGINS: $$[QT_INSTALL_PLUGINS])
message(Data files QT_INSTALL_DATA: $$[QT_INSTALL_DATA])
message(Translation files QT_INSTALL_TRANSLATIONS: $$[QT_INSTALL_TRANSLATIONS])
message(Settings QT_INSTALL_CONFIGURATION: $$[QT_INSTALL_CONFIGURATION])
message(Examples QT_INSTALL_EXAMPLES: $$[QT_INSTALL_EXAMPLES])
message(OUT_PWD: $$OUT_PWD)
message(DEFINES is : $$[DEFINES])
message(TEMPLATE is: $$TEMPLATE)
message(CONFIG is: $$CONFIG)
message(DESTDIR: $$DESTDIR)

TEMPLATE = subdirs

include($$PWD/config.pri)

SUBDIRS += \
    thirdparty \
#    QtJsonSerializer \
#    qthttpserver \
#    qtpromise \
#    quazip \
    log4qt \

SUBDIRS += \
    QtComposition \
    QtEventBus \
    QtRestClient \
    Hybridge \
    HybridgeQt \
    HybridgeC \
    HybridgeJni \
    QtTestbed \

QtEventBus.depends = QtComposition
QtRestClient.depends = log4qt

HybridgeJni.file = HybridgeJni/jni/HybridgeJni.pro
HybridgeQt.depends = QtComposition Hybridge
HybridgeC.depends = Hybridge
HybridgeJni.depends = Hybridge

SUBDIRS += \
    InkCanvas \
    ShowBoard \
    Geometry \
    TeachingTools \
    MultiMedia \
    PageBox \
    InteractBase \
#    UiBase \
#    TalWeb \

ShowBoard.depends = QtComposition QtEventBus
Geometry.depends = ShowBoard
MultiMedia.depends = ShowBoard
PageBox.depends = ShowBoard
InteractBase.depends = InkCanvas PageBox ShowBoard
TeachingTools.depends = InkCanvas PageBox ShowBoard

SUBDIRS += \
    EventsLog \
    EventsLogService \
    Upgrade \
    Guide \
    Salt/salt/Salt.pro \

Upgrade.subdir = Assistant/Upgrade
Guide.subdir = Assistant/Guide
EventsLogService.file = EventsLog/EventsLogService.pro

EventsLog.depends = QtComposition QtRestClient
EventsLogService.depends = QtComposition QtRestClient EventsLog
TalWeb.depends = EventsLog
Upgrade.depends = QtComposition QtRestClient
Guide.depends = QtEventBus

SUBDIRS += \
#    XhtHtml/Html.pro \
#    InteractionLib \
    TeachingLib \
    Account \
    Main \

Account.depends = QtRestClient EventsLog
TeachingLib.depends = QtRestClient PageBox TeachingTools EventsLog \
    Account Guide
Main.depends = EventsLog \
    TeachingLib TeachingTools Salt/salt/Salt.pro Upgrade Guide

SUBDIRS += QtApp

QtApp.depends = QtRestClient Geometry ShowBoard TeachingTools \
