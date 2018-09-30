/****************************************************************************
**
** Copyright (C) 2018 Leonid Manieiev.
** Contact: leonid.manieiev@gmail.com
**
** This file is part of Versality Club.
**
** Versality Club is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** Versality Club is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with Foobar.  If not, see <https://www.gnu.org/licenses/>.
**
****************************************************************************/

import "../"
import "../js/toDp.js" as Convert
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Page
{
    id: initialPage
    height: Style.screenHeight
    width: Style.screenWidth

    ColumnLayout
    {
        id: middleButtonsColumn
        spacing: Style.screenHeight*0.07
        width: parent.width*0.8
        anchors.centerIn: parent

        ControlButton
        {
            id: signUpButton
            Layout.fillWidth: true
            buttonText: "ЗАРЕГИСТРИРОВАТЬСЯ"
            onClicked: signLogLoader.source = "signUpPage.qml"
        }

        ControlButton
        {
            id: logInButton
            Layout.fillWidth: true
            buttonText: "ВОЙТИ"
            onClicked: signLogLoader.source = "logInPage.qml"
        }
    }

    Loader
    {
        id: signLogLoader
        anchors.fill: parent
    }
}
