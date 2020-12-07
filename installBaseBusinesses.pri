# install inkcanvas
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../InkCanvas/release/ -lInkCanvas
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../InkCanvas/debug/ -lInkCanvasd
else:unix: LIBS += -L$$OUT_PWD/../InkCanvas/ -lInkCanvas
INCLUDEPATH += $$PWD/InkCanvas
DEPENDPATH += $$PWD/InkCanvas


# install showboard
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../ShowBoard/release/ -lShowBoard
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../ShowBoard/debug/ -lShowBoardd
else:unix: LIBS += -L$$OUT_PWD/../ShowBoard/ -lShowBoard
INCLUDEPATH += $$PWD/ShowBoard
DEPENDPATH += $$PWD/ShowBoard


# install TalWeb
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../TalWeb/release/ -lTalWeb
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../TalWeb/debug/ -lTalWebd
else:unix: LIBS += -L$$OUT_PWD/../TalWeb/ -lTalWeb
INCLUDEPATH += $$PWD/TalWeb
DEPENDPATH += $$PWD/TalWeb


# install account
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../Account/release/ -lAccount
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../Account/debug/ -lAccountd
else:unix: LIBS += -L$$OUT_PWD/../Account/ -lAccount
INCLUDEPATH += $$PWD/Account
DEPENDPATH += $$PWD/Account



