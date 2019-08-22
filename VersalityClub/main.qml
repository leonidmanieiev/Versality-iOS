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

ApplicationWindow
{
    id: appWindow
    visible: true
    width: Vars.screenWidth
    height: Vars.screenHeight
    color: Vars.whiteColor

    function runPageSelection()
    {
        // if user tap on push -> open corresponding promotion
        if(AppSettings.value("push/open") === "true")
        {
            AppSettings.remove("push");
            appWindowLoader.setSource("qml/xmlHttpRequest.qml",
            {
                "api": Vars.promFullViewModel,
                "functionalFlag": 'user/fullprom',
                "promo_id": AppSettings.value("promo/id")
            });
        }
        // if user doesn't have hash -> he doesn't have account -> open initialPage
        else if(AppSettings.value("user/hash") === undefined)
        {
            appWindowLoader.source = "qml/initialPage.qml";
        }
        // otherwise open mapPage
        else
        {
            appWindowLoader.source = "qml/mapPage.qml"
        }
    }
    
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
    
    Timer
    {
        running: true
        // wait for AppSettings.value("push/open")
        // to be set in appdelegage::openPromotion
        interval: 30
        onTriggered: runPageSelection()
    }
}
