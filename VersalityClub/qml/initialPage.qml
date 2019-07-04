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

//sign up and log in buttons page
import "../"
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Page
{
    id: initialPage
    enabled: Vars.isConnected
    height: Vars.screenHeight
    width: Vars.screenWidth

    //checking internet connetion
    Network { toastMessage: toastMessage }

    Image
    {
        id: background
        clip: true
        width: parent.width
        height: parent.height
        source: "../backgrounds/init_page_bg.png"
    }

    Image
    {
        id: header_logo_full
        clip: true
        source: "../icons/logo_full.svg"
        sourceSize.width: parent.width*0.40
        sourceSize.height: parent.width*0.08
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.09
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Image
    {
        id: footer_logo
        clip: true
        source: "../icons/logo.svg"
        sourceSize.width: parent.width*0.25
        sourceSize.height: parent.width*0.25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height*0.08
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    ColumnLayout
    {
        id: middleButtonsColumn
        width: parent.width*0.8
        anchors.centerIn: parent
        spacing: parent.height*0.035

        ControlButton
        {
            id: signUpButton
            Layout.fillWidth: true
            labelText: Vars.signup
            buttonClickableArea.onClicked:
            {
                PageNameHolder.push("initialPage.qml");
                initialPageLoader.source = "signUpPage.qml";
            }
        }

        ControlButton
        {
            id: logInButton
            Layout.fillWidth: true
            labelText: Vars.login
            buttonClickableArea.onClicked:
            {
                PageNameHolder.push("initialPage.qml");
                initialPageLoader.source = "logInPage.qml";
            }
        }
    }//middleButtonsColumn

    ToastMessage { id: toastMessage }

    Loader
    {
        id: initialPageLoader
        asynchronous: true
        anchors.fill: parent
        visible: status == Loader.Ready

        function reload()
        {
            var oldSource = source;
            source = "";
            source = oldSource;
        }
    }

    //setting active focus for key capturing
    Component.onCompleted: initialPage.forceActiveFocus();


    Keys.onReleased:
    {
        //back button pressed for android and windows
        if (event.key === Qt.Key_Back || event.key === Qt.Key_B)
        {
            event.accepted = true;
            var pageName = PageNameHolder.pop();

            if(pageName === "")
                appWindow.close();
            else initialPageLoader.source = pageName;

            //to avoid not loading bug
            initialPageLoader.reload();
        }
    }
}
