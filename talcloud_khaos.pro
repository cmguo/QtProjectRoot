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


mydoc.files = doc/*
mydoc.path = $$OUT_PWD/


INSTALLS += mydoc


include($$PWD/config.pri)

# This is my first qmake function
defineReplace(hello) {
    message($$1)
    return($$1)
}

$$hello("This is my first fucntion")


#thirdparty.subdir = thirdparty
#QtComposition.subdir = QtComposition
#log4qt.subdir = log4qt
#QtEventBus.subdir = QtEventBus
#QtRestClient.subdir = QtRestClient
#InkCanvas.subdir = InkCanvas


SUBDIRS += \
    thirdparty \
    QtComposition \
    #qtpromise \
    #QtJsonSerializer \
    log4qt \
    QtEventBus \
    QtRestClient \
    InkCanvas \

QtEventBus.depends = QtComposition
QtRestClient.depends = log4qt



SUBDIRS += \
    XhtHtml/Html.pro \
    Salt/salt/Salt.pro \
    UiBase \

#Html.subdir = XhtHtml
#Salt.subdir = Salt/salt
#UiBase.subdir = UiBase


SUBDIRS += \
    EventsLog \
#    EventsLog\EventsLogService.pro \
    EventsLogService \
    TalWeb \
    Geometry \
    ShowBoard \
    Upgrade \
    TeachingTools \
    TeachingLib \
    Account \
    Main \


Upgrade.subdir = Assistant/Upgrade
EventsLogService.file = EventsLog\EventsLogService.pro


#EventsLog.subdir = EventsLog
#EventsLogService = EventsLog
#TalWeb.subdir = TalWeb
#Geometry.subdir = Geometry
#ShowBoard.subdir = ShowBoard
#Upgrade.subdir = Upgrade
#Account.subdir = Account
#TeachingTools.subdir = TeachingTools
#TeachingLib.subdir = TeachingLib
#Main.subdir = Main

EventsLog.depends = QtComposition QtRestClient
EventsLogService.depends = QtComposition QtRestClient EventsLog
TalWeb.depends = EventsLog UiBase
Geometry.depends = QtComposition ShowBoard
ShowBoard.depends = QtComposition QtEventBus
Upgrade.depends = QtComposition QtRestClient
Account.depends = QtComposition QtRestClient QtEventBus UiBase TalWeb EventsLog log4qt TalWeb UiBase
TeachingTools.depends = QtComposition QtEventBus InkCanvas ShowBoard
TeachingLib.depends = QtComposition QtRestClient QtEventBus UiBase EventsLog TalWeb XhtHtml/Html.pro Geometry ShowBoard  Account TeachingTools InkCanvas
Main.depends = QtComposition QtRestClient QtEventBus InkCanvas UiBase EventsLog TalWeb XhtHtml/Html.pro Geometry ShowBoard Account TeachingLib TeachingTools Salt/salt/Salt.pro Upgrade









