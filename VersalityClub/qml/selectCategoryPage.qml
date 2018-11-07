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

//page where user select categories
import "../"
import "../js/helpFunc.js" as Helper
import QtQuick 2.11
import QtQuick.Controls 2.4

Page
{
    property string strCatsJSON: ''

    id: selectCategoryPage
    enabled: Style.isConnected
    height: Style.screenHeight
    width: Style.screenWidth

    //checking internet connetion
    Network { toastMessage: toastMessage }

    Rectangle
    {
        id: background
        anchors.fill: parent
        color: Style.mainPurple
    }

    ListView
    {
        id: catsListView
        clip: true
        width: parent.width
        height: parent.height*0.6
        anchors.centerIn: parent
        model: catsModel
        delegate: catsDelegate
    }

    ListModel { id: catsModel }

    Component
    {
        id: catsDelegate
        Column
        {
            width: Style.screenWidth*0.8
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: Style.screenHeight*0.03
            Rectangle
            {
                id: catsItem
                height: Style.screenHeight*0.09
                width: Style.screenWidth*0.8
                radius: height*0.5
                color: "transparent"
                border.color: Style.backgroundWhite
                border.width: height*0.06

                Text
                {
                    id: catsItemText
                    x: parent.radius
                    anchors.verticalCenter: parent.verticalCenter
                    color: Style.backgroundWhite
                    font.pixelSize: Helper.toDp(15, Style.dpi)
                    text: title
                }

                Rectangle
                {
                    id: catsItemArrow
                    color: "red"
                    width: parent.radius
                    height: parent.radius
                    radius: height*0.5
                    anchors.right: parent.right
                    anchors.rightMargin: parent.radius
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea
                {
                    id: catsClickableArea
                    anchors.fill: parent
                    onClicked: catsModel.setProperty(index, "collapsed", !collapsed)
                }
            }//Rectangle

            Loader
            {
                id: catsItemLoader
                visible: !collapsed
                property variant subCatsModel : subcats
                sourceComponent: collapsed ? null : subCatsDelegate
                onStatusChanged: if (status == Loader.Ready) item.model = subCatsModel
            }
        }//Column
    }//Component

    Component
    {
        id: subCatsDelegate
        Column
        {
            property alias model: subCatsRepeater.model
            width: Style.screenWidth*0.8
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: Style.screenHeight*0.01
            Repeater
            {
                id: subCatsRepeater
                delegate: Rectangle
                {
                    id: subCatsItem
                    color: AppSettings.contains(subid) ? Style.toastGrey : "transparent"
                    height: Style.screenHeight*0.09
                    width: Style.screenWidth*0.8
                    radius: height*0.5
                    border.color: Style.mainPurple
                    border.width: height*0.06

                    Text
                    {
                        id: subCatsText
                        x: parent.radius*2
                        width: parent.width*0.7
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: Helper.toDp(15, Style.dpi)
                        color: AppSettings.contains(subid) ? Style.backgroundBlack : Style.backgroundWhite
                        wrapMode: Text.WordWrap
                        text: subtitle
                    }

                    Rectangle
                    {
                        id: catsSelectedIcon
                        visible: AppSettings.contains(subid)
                        color: "green"
                        width: parent.radius
                        height: parent.radius
                        radius: height*0.5
                        anchors.left: parent.left
                        anchors.leftMargin: parent.radius*0.8
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea
                    {
                        id: subCatsClickableArea
                        anchors.fill: parent
                        onClicked:
                        {
                            if(subCatsItem.color == Style.toastGrey)
                            {
                                subCatsItem.color = "transparent";
                                subCatsText.color = Style.backgroundWhite
                                catsSelectedIcon.visible = false;
                                AppSettings.removeCat(subid);
                            }
                            else
                            {
                                subCatsItem.color = Style.toastGrey;
                                subCatsText.color = Style.backgroundBlack;
                                catsSelectedIcon.visible = true;
                                AppSettings.insertCat(subid);
                            }
                        }
                    }
                }//delegate: Rectangle
            }//Repeater
        }//Column
    }//Component

    ControlButton
    {
        id: saveSelectedButton
        setWidth: Style.screenWidth*0.8
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: parent.height*0.1
        buttonText: qsTr("СОХРАНИТЬ\nИ ВЕРНУТЬСЯ К НАСТРОЙКАМ")
        onClicked:
        {
            PageNameHolder.pop();
            chooseCategoryPageLoader.setSource("xmlHttpRequest.qml",
                                              { "serverUrl": 'http://patrick.ga:8080/api/user/categories?',
                                                "functionalFlag": 'user/refresh-cats'
                                              });
        }
    }

    ToastMessage { id: toastMessage }

    Component.onCompleted:
    {
        //setting active focus for key capturing
        selectCategoryPage.forceActiveFocus();

        var catsJSON = JSON.parse(strCatsJSON);
        Helper.catsJsonToListModel(catsJSON);
    }

    Keys.onReleased:
    {
        //back button pressed for android and windows
        if (event.key === Qt.Key_Back || event.key === Qt.Key_B)
        {
            event.accepted = true;
            var pageName = PageNameHolder.pop();
            chooseCategoryPageLoader.source = pageName;

            //to avoid not loading bug
            chooseCategoryPageLoader.reload();
        }
    }

    Loader
    {
        id: chooseCategoryPageLoader
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
}
