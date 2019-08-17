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

//this class will reload app when user clicked on push
//but app is currently in background or foreground
#ifndef appreloader_h
#define appreloader_h

#include <QObject>
#include <QQmlApplicationEngine>

class AppReloader
{
public:
    static AppReloader& get_instance()
    {
        static AppReloader instance;
        return instance;
    }
    AppReloader() { }
    AppReloader(const AppReloader&) = delete;
    void operator=(const AppReloader&) = delete;
    void reloadMain()
    {
        if(m_engine)
        {
            m_engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
        }
    }
    void setEngine(QQmlApplicationEngine* engine) { m_engine = engine; }
private:
    QQmlApplicationEngine* m_engine;
};

#endif /* appreloader_h */
