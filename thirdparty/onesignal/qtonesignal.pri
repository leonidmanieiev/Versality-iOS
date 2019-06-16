INCLUDEPATH += $$PWD

SOURCES += \
    $$PWD/qonesignal.cpp

HEADERS += \
    $$PWD/qonesignal.h

ios {
    OBJECTIVE_SOURCES += \
        $$PWD/qonesignal_ios.mm
}

OTHER_FILES += \
    $$PWD/README.md \
    $$files($$PWD/android/src/org/pwf/qtonesignal/*)

DISTFILES += \
    $$PWD/android/src/org/pwf/qtonesignal/QOneSignalNotificationReceivedHandler.java \
    $$PWD/android/src/org/pwf/qtonesignal/QOneSignalNotificationOpenedHandler.java
