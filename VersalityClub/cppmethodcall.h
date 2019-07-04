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

//Wrapper, so I can call cpp methods from QML
#ifndef CPPMETHODCALL_H
#define CPPMETHODCALL_H

#include "appsettings.h"

#include <QObject>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QStandardPaths>

class CppMethodCall : public QObject
{
    Q_OBJECT
public:
    explicit CppMethodCall([[maybe_unused]] QObject *parent = nullptr) { }

    static bool locationServiceStarted;

    Q_INVOKABLE void saveHashToFile()
    {
        //if user has an account so do hash
        if(!AppSettings().value("user/hash").toString().isEmpty())
        {
            // on iOS we have to create dir before pass it to the constructor of QFile
            QString dir = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).value(0);
            if(!QDir(dir).exists())
            {
                if (!QDir().mkpath(dir))
                {
                     qDebug() << "Failed to create " << dir;
                     return;
                }
            }

            // creating file
            QFile file(dir + "/hash.txt");
            if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
            {
                qDebug() << "Failed to open " << dir;
                return;
            }

            // saving user hash to file
            QTextStream out(&file);
            out << AppSettings().value("user/hash").toString();
            out.flush();
            file.close();
        }
        else qDebug() << "CppMethodCall::saveHashToFile: No user hash yet";
    }

    Q_INVOKABLE void startLocationService()
    {
        //if user has an account so do hash
        if(!AppSettings().value("user/hash").toString().isEmpty())
        {
            if(!locationServiceStarted)
            {
                locationServiceStarted = true;

                // starting location service
                // todo uncomment bellow
                /*QAndroidJniObject::callStaticMethod<void>(
                "org.versalityclub.LocationService", "startLocationService",
                "(Landroid/content/Context;)V", QtAndroid::androidActivity().object());*/
            }
            else qDebug() << "CppMethodCall::startLocationService: locationServiceStarted is TRUE";
        }
        else qDebug() << "CppMethodCall::startLocationService: No user hash yet";
    }
};

#endif // CPPMETHODCALL_H
