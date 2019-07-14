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

#ifndef M_LOGGER_H
#define M_LOGGER_H

extern "C"

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

@interface Logger : NSObject

- (void) log:(NSString*) str;

- (void) sendLog:(NSString*) log;

- (void) sendCoords:(double) lat :(double) lon;

- (bool) httpGetRequest:(NSString*) url;

- (void) saveHashToFile:(NSString*) userHash;

- (NSString*) getHashFromFile;

- (NSString*) currectTime;

+ (Logger*) sharedSingleton;

@end

#endif // M_LOGGER_H

