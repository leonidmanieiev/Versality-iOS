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
ios_icon.files = $$files($$PWD/ios/AppIcon*.png)
QMAKE_BUNDLE_DATA += ios_icon
app_launch_images.files = $$PWD/ios/Launch.xib $$PWD/ios/image_for_launch_screen.png
QMAKE_BUNDLE_DATA += app_launch_images


# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
