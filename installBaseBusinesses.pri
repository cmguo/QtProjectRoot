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


# install geometry
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../Geometry/release/ -lGeometry
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../Geometry/debug/ -lGeometryd
else:unix: LIBS += -L$$OUT_PWD/../Geometry/ -lGeometry
INCLUDEPATH += $$PWD/Geometry
DEPENDPATH += $$PWD/Geometry


# install qttalwidget
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../QtTalWidget/release/ -lQtTalWidget
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../QtTalWidget/debug/ -lQtTalWidgetd
else:unix: LIBS += -L$$OUT_PWD/../QtTalWidget/ -lQtTalWidget
INCLUDEPATH += $$PWD/QtTalWidget
DEPENDPATH += $$PWD/QtTalWidget


# install account
win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../Account/release/ -lAccountd
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../Account/debug/ -lAccountd
else:unix: LIBS += -L$$OUT_PWD/../Account/ -lAccountd
INCLUDEPATH += $$PWD/Account
DEPENDPATH += $$PWD/Account


win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../TeachingTools/release/ -lTeachingTools
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../TeachingTools/debug/ -lTeachingToolsd
else:unix: LIBS += -L$$OUT_PWD/../TeachingTools/ -lTeachingTools
INCLUDEPATH += $$PWD/TeachingTools
DEPENDPATH += $$PWD/TeachingTools


win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../TeachingLib/release/ -lTeachingLib
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../TeachingLib/debug/ -lTeachingLibd
else:unix: LIBS += -L$$OUT_PWD/../TeachingLib/ -lTeachingLib
INCLUDEPATH += $$PWD/TeachingLib
DEPENDPATH += $$PWD/TeachingLib
