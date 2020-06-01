# install githubs


# install log4qt
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../log4qt/release/ -llog4qt
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../log4qt/debug/ -llog4qtd
else:unix: LIBS += -L$$OUT_PWD/../log4qt/ -llog4qt
INCLUDEPATH += $$PWD/log4qt
INCLUDEPATH += $$PWD/log4qt/src
DEPENDPATH += $$PWD/log4qt


# install jsonserializer
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../QtJsonSerializer/lib/ -lQt5JsonSerializer
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../QtJsonSerializer/lib/ -lQt5JsonSerializerd
else:mac: LIBS += -F$$OUT_PWD/../QtJsonSerializer/lib -framework QtJsonSerializer
else:unix: LIBS += -L$$OUT_PWD/../QtJsonSerializer/lib/ -lQt5JsonSerializer
INCLUDEPATH += $$OUT_PWD/../QtJsonSerializer/include/


# install qtpromise
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../QtComposition/release/ -lQtComposition
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../QtComposition/debug/ -lQtCompositiond
else:unix: LIBS += -L$$OUT_PWD/../QtComposition/ -lQtComposition
INCLUDEPATH += $$PWD/QtComposition
DEPENDPATH += $$PWD/QtComposition


#install
INCLUDEPATH += $$PWD/QtPromise/src
INCLUDEPATH += $$PWD/qtpromise/src/qtpromise $$PWD/qtpromise/include
DEPENDPATH += $$PWD/qtpromise/src/qtpromise


# install qtrestclient
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../QtRestClient/release/ -lQtRestClient
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../QtRestClient/debug/ -lQtRestClientd
else:unix: LIBS += -L$$OUT_PWD/../QtRestClient/ -lQtRestClient
INCLUDEPATH += $$PWD/QtRestClient
DEPENDPATH += $$PWD/QtRestClient



# install logs
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../EventsLog/release/ -lEventsLog
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../EventsLog/debug/ -lEventsLogd
else:unix: LIBS += -L$$OUT_PWD/../EventsLog/ -lEventsLog
INCLUDEPATH += $$PWD/EventsLog
DEPENDPATH += $$PWD/EventsLog



# install qteventbus
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../QtEventBus/release/ -lQtEventBus
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../QtEventBus/debug/ -lQtEventBusd
else:unix: LIBS += -L$$OUT_PWD/../QtEventBus/ -lQtEventBus
INCLUDEPATH += $$PWD/QtEventBus
DEPENDPATH += $$PWD/QtEventBus


win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../UiBase/release/ -lUiBase
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../UiBase/debug/ -lUiBased
else:unix: LIBS += -L$$OUT_PWD/../UiBase/ -lUiBase
INCLUDEPATH += $$PWD/UiBase
DEPENDPATH += $$PWD/UiBase
