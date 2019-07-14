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

import '.' //QTBUG-34418, singletons require explicit import to load qmldir file
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.11
import QtPositioning 5.12

ApplicationWindow
{
    id: appWindow
    visible: true
    width: Vars.screenWidth
    height: Vars.screenHeight
    color: Vars.whiteColor

    Loader
    {
        id: appWindowLoader
        asynchronous: false
        anchors.fill: parent
        visible: status == Loader.Ready
        //whether user was not signed(loged) in
        source: AppSettings.value("user/hash") === undefined ?
                     "qml/initialPage.qml" : "qml/mapPage.qml"
    }

    // to initiate location permission request from iOS before running into mapPage
    PositionSource
    {
        active: true
        updateInterval: 1

        onPositionChanged:
        {
            if(isNaN(position.coordinate.latitude))
                update();
            else active = false;
        }
    }

    onClosing:
    {
        // start location service if user has secret and this is app first closing
        if(AppSettings.value("user/hash") !== undefined &&
           AppSettings.value("user/first_launch") === undefined)
        {
            AppSettings.beginGroup("user");
            AppSettings.setValue("first_launch", 1);
            AppSettings.endGroup();
        }
    }
}
