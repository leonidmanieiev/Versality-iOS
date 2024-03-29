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

//apply ratio between physical pixels and device-independent pixels
function applyDpr(px, dpr)
{
    return px*dpr;
}

//HTTP status code decoder
function httpErrorDecoder(statusCode)
{
    var decodedError;
    switch(statusCode)
    {
        case 0: decodedError = "Сервер не отвечает"; break;
        case 400: decodedError = "Некорректный запрос"; break;
        case 403: decodedError = "Доступ запрещен"; break;
        case 404: decodedError = "Информация не найдена"; break;
        case 408: decodedError = "Истекло время ожидания"; break;
        case 500: decodedError = "Ошибка сервера"; break;
        default: decodedError = "Неизвестная ошибка"; break;
    }

    return decodedError + ".\nПопробуйте позже.";
}

function isStringAnUrl(str)
{
    var res1 = str.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
    var res2 = str.charAt(0) === '/';
    return (res1 !== null) || res2;
}

function adjastPicUrl(picUrl)
{
    return picUrl.charAt(0) === '/' ? "https://club.versality.ru" + picUrl : picUrl;
}

/*****************MODELS GENERATION**************/

//puts categories from JSON to model for listview
function catsJsonToListModel(catsJSON)
{
    for(var i in catsJSON)
    {
        catsModel.append({
                             "id": catsJSON[i].id,
                             "title": catsJSON[i].title,
                             "collapsed": true,
                             "subcats": []
                        });

        for(var j in catsJSON[i].subcats)
            catsModel.get(i).subcats.append({
                                                "subid": catsJSON[i].subcats[j].id,
                                                "subtitle": catsJSON[i].subcats[j].title
                                           });
    }
}

//puts promotions from JSON to model for listview
function promsJsonToListModel(promsJSON)
{
    for(var i in promsJSON)
    {
        promsModel.append({
                             "id": promsJSON[i].id,
                             "title": promsJSON[i].title,
                             "description": promsJSON[i].desc,
                             "picture": promsJSON[i].picture,
                             "company_logo": promsJSON[i].company_logo
                         });
    }
}

//puts promotion info from JSON to model for markers on map
function promsJsonToListModelForMarkers(promJSON)
{
    promsMarkersModel.clear();

    for(var i in promJSON)
    {
        promsMarkersModel.append({
                                    "id": promJSON[i].id,
                                    "title": promJSON[i].title,
                                    "icon": promJSON[i].icon,
                                    "lat": promJSON[i].lat,
                                    "lon": promJSON[i].lon,
                                    "childs": [],
                                    "cntOfChilds": promJSON[i].childs.length
                                });

        for(var j in promJSON[i].childs)
            promsMarkersModel.get(i).childs.append({
                                                "cid": promJSON[i].childs[j].id,
                                                "ctitle": promJSON[i].childs[j].title,
                                                "cicon": promJSON[i].childs[j].icon,
                                                "clat": promJSON[i].childs[j].lat,
                                                "clon": promJSON[i].childs[j].lon
                                           });
    }
}
