QT += quick network webview svg positioning location
CONFIG += c++17

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        main.cpp \
    promotion.cpp \
    promotionClusters.cpp

OBJECTIVE_SOURCES += \
    appdelegate.mm \
    locationService.mm \
    logger.mm \
    qlogger.mm

RESOURCES += \
    versalityclub.qrc

HEADERS += \
    appdelegate.h \
    locationService.h \
    logger.h \
    networkinfo.h \
    appsettings.h \
    geolocationinfo.h \
    promotion.h \
    pagenameholder.h \
    promotionClusters.h \
    qlogger.h

QMAKE_INFO_PLIST = ios/Info.plist

# uncomment after... i do not know when
# include(../thirdparty/onesignal/qtonesignal.pri)

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
