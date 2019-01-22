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

//Marker for cluster point on map
import "../"
import "../js/helpFunc.js" as Helper
import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle
{
    property int amountOfChilds

    id: promClusterIcon
    radius: height*0.5
    color: Vars.fontsPurple

    FontLoader
    {
        id: regulatText
        source: "../fonts/Qanelas_Regular.ttf"
    }

    Label
    {
        id: cntOfChildProms
        anchors.centerIn: parent
        text: amountOfChilds
        font.pixelSize: Helper.toDp(Vars.defaultFontPixelSize,
                                    Vars.dpi)
        font.family: regulatText.name
        color: Vars.backgroundWhite
    }
}