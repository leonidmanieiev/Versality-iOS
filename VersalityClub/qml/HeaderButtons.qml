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

//company page header buttons
import "../"
import QtQuick 2.11
import QtQuick.Layouts 1.3

RowLayout
{
    property string currPageName: ''
    property string compInfoButtonIcon: ''
    property string compMapButtonIcon: ''
    property string compListButtonIcon: ''

    //set buttons states depand on currPageName
    function setButtonsStates()
    {
        switch(currPageName)
        {
            case "companyPage.qml":
                compInfoButtonIcon = "../icons/comp_info_on";
                compMapButtonIcon = "../icons/comp_proms_map_off";
                compListButtonIcon = "../icons/comp_proms_list_off";
                break;
            case "companyMapPage.qml":
                compInfoButtonIcon = "../icons/comp_info_off";
                compMapButtonIcon = "../icons/comp_proms_map_on";
                compListButtonIcon = "../icons/comp_proms_list_off";
                break;
            case "companyListPage.qml":
                compInfoButtonIcon = "../icons/comp_info_off";
                compMapButtonIcon = "../icons/comp_proms_map_off";
                compListButtonIcon = "../icons/comp_proms_list_on";
                break;
        }
    }

    id: headerButtonsLayout
    width: parent.width
    height: Vars.footerButtonsFieldHeight
    anchors.top: parent.top

    IconedButton
    {
        id: backButton
        width: Vars.headerButtonsHeight
        height: Vars.headerButtonsHeight
        Layout.alignment: Qt.AlignHCenter
        buttonIconSource: "../icons/comp_back.png"
        clickArea.onClicked:
        {
            PageNameHolder.pop();
            //to avoid not loading bug
            appWindowLoader.source = "";
            appWindowLoader.source = "promotionPage.qml";
        }
    }

    IconedButton
    {
        id: compInfoButton
        width: Vars.headerButtonsHeight
        height: Vars.headerButtonsHeight
        Layout.alignment: Qt.AlignHCenter
        buttonIconSource: compInfoButtonIcon
        clickArea.onClicked:
        {
            if(currPageName != "companyPage.qml")
            {
                currPageName = "companyPage.qml";
                parent.parent.loader.setSource(currPageName);
                setButtonsStates();
            }
        }
    }

    IconedButton
    {
        id: compMapButton
        width: Vars.headerButtonsHeight
        height: Vars.headerButtonsHeight
        Layout.alignment: Qt.AlignHCenter
        buttonIconSource: compMapButtonIcon
        clickArea.onClicked:
        {
            if(currPageName != "companyMapPage.qml")
            {
                currPageName = "companyMapPage.qml";
                parent.parent.loader.setSource("mapPage.qml",
                    {"allGood": true, "requestFromCompany": true});
                setButtonsStates();
            }
        }
    }

    IconedButton
    {
        id: compListButton
        width: Vars.headerButtonsHeight
        height: Vars.headerButtonsHeight
        Layout.alignment: Qt.AlignHCenter
        buttonIconSource: compListButtonIcon
        clickArea.onClicked:
        {
            if(currPageName != "companyListPage.qml")
            {
                currPageName = "companyListPage.qml";
                parent.parent.loader.setSource("listViewPage.qml",
                    {"allGood": true, "requestFromCompany": true});
                setButtonsStates();
            }
        }
    }

    Component.onCompleted:
    {
        currPageName = "companyPage.qml";
        setButtonsStates();
    }

}//RowLayout
