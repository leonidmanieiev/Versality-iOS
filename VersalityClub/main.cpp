/****************************************************************************
**
** Copyright (C) 2019 Leonid Manieiev.
** Contact: leonid.manieiev@gmail.com
**
** This file is part of Versality.
**
** Versality is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** Versality is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with Versality. If not, see <https://www.gnu.org/licenses/>.
**
****************************************************************************/

#include "appsettings.h"
#include "network.h"
#include "geolocationinfo.h"
#include "pagenameholder.h"
#include "promotionClusters.h"
#include "qlogger.h"

#include <QQmlApplicationEngine>
#include <QtWebView/QtWebView>
#include <QGuiApplication>
#include <QTextStream>
#include <QSslSocket>
#include <QDebug>
#include <QFile>

bool AppSettings::needToRemovePromsAndComps = true;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QtWebView::initialize();

    qmlRegisterType<Network>("Network", 0, 9, "Network");
    qmlRegisterType<AppSettings>("org.versalityclub", 0, 8, "AppSettings");
    qmlRegisterType<GeoLocationInfo>("GeoLocation", 0, 8, "GeoLocationInfo");
    qmlRegisterType<PageNameHolder>("org.versalityclub", 0, 8, "PageNameHolder");
    qmlRegisterType<PromotionClusters>("org.versalityclub", 0, 8, "PromotionClusters");
    qmlRegisterSingletonType<QLogger>("QLogger", 1, 0, "QLogger", &QLogger::singletonProvider);

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QLogger::saveHashToFile();

    return app.exec();
}
