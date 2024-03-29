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

//logo and page title footer
import "../"
import "../js/helpFunc.js" as Helper
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Network 0.9

RowLayout
{
    property bool showInfoButton: false
    property bool infoClicked: false
    property string pageTitleText
    property string pressedFromPageName: ''

    id: logoAndPageTitle
    anchors.top: parent.top
    height: Vars.screenHeight*0.15
    width: Vars.screenWidth
    anchors.horizontalCenter: parent.horizontalCenter

    function itemSize()
    {
        if(Vars.isXSMax) return 0.035
        else if(Vars.isXR || Vars.isXorXS) return 0.03
        else if(Vars.isFives || Vars.isThose) return 0.02
        else return 0.01 //pluses
    }
    
    ToastMessage { id: toastMessage }

    Network { id: network }

    Image
    {
        id: logo
        clip: true
        source: "../icons/logo_white_fill.svg"
        Layout.preferredWidth: Vars.screenHeight*0.1*Vars.iconHeightFactor
        Layout.preferredHeight: Vars.screenHeight*0.1*Vars.iconHeightFactor
        Layout.alignment: Qt.AlignHCenter
    }

    FontLoader
    {
        id: boldText;
        source: Vars.boldFont
    }

    Label
    {
        id: pageTitle
        text: pageTitleText
        color: Vars.whiteColor
        height: Vars.screenHeight*0.1
        Layout.alignment: Qt.AlignLeft
        font.family: boldText.name
        font.bold: true
        font.pixelSize: Helper.applyDpr(9, Vars.dpr)
    }

    Item
    {
        visible: true //(Vars.isXR || Vars.isXorXS || isXSMax)
        width: Vars.screenHeight  * Vars.iconHeightFactor * itemSize()
        height: Vars.screenHeight * Vars.iconHeightFactor * itemSize()
        Layout.rightMargin: parent.height*0.04
    }
    
    /*Rectangle
    {
        id: infoButtonField
        visible: showInfoButton
        width: Vars.screenHeight*0.065*Vars.iconHeightFactor
        height: Vars.screenHeight*0.065*Vars.iconHeightFactor
        Layout.alignment: Qt.AlignTop
        Layout.topMargin: parent.height*0.25
        Layout.rightMargin: parent.height*0.04
        radius: height*0.5
        color: infoClicked ? Vars.whiteColor : "transparent"

        IconedButton
        {
            id: infoButton
            width: Vars.screenHeight*0.05
            height: Vars.screenHeight*0.05
            anchors.centerIn: parent
            buttonIconSource: infoClicked ? "../icons/app_info_on.svg"
                                          : "../icons/app_info_off.svg"
            clickArea.onClicked:
            {
                if(network.hasConnection())
                {
                    toastMessage.close();
                    if(infoClicked)
                    {
                        appWindowLoader.source = 'profileSettingsPage.qml';
                        infoClicked = false;
                    }
                    else
                    {
                        if(pressedFromPageName === 'selectCategoryPage.qml')
                        {
                            appWindowLoader.setSource("xmlHttpRequest.qml",
                                                      { "api": Vars.userSelectCats,
                                                        "functionalFlag": 'user/refresh-cats',
                                                        "nextPageAfterCatsSave": 'appInfoPage.qml'
                                                      });
                        }
                        else
                        {
                            appWindowLoader.source = "appInfoPage.qml";
                        }

                        PageNameHolder.push('profileSettingsPage.qml')
                        infoClicked = true;
                    }
                } // hasConnection
                else
                {
                    toastMessage.setTextNoAutoClose(Vars.noInternetConnection);
                }
            } // onClicked
        } // IconedButton
    } // infoButtonField*/
}
