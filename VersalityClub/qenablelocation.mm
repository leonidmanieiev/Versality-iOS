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

#include "qenablelocation.h"
#include "enablelocation.h"
#include <QDebug>

QEnableLocation::QEnableLocation(QObject* parent) : QObject(parent) { }

bool QEnableLocation::askEnableLocationAlways()
{
    qDebug() << "QEnableLocation::askEnableLocationAlways()";
    return [[EnableLocation sharedSingleton] askEnableLocationAlways];
}

bool QEnableLocation::askEnableLocation()
{
    qDebug() << "QEnableLocation::askEnableLocation()";
    return [[EnableLocation sharedSingleton] askEnableLocation];
}

bool QEnableLocation::askEnableBR()
{
    qDebug() << "QEnableLocation::askEnableBR()";
    return [[EnableLocation sharedSingleton] askEnableBR];
}
