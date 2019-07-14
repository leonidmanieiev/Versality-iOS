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

#ifndef LOCATIONSERVICE_H
#define LOCATIONSERVICE_H

extern "C"

#include <Foundation/Foundation.h>
#include <CoreLocation/CoreLocation.h>

@interface LocationService : NSObject <CLLocationManagerDelegate> {
    CLLocationManager* locationManager;
}

FOUNDATION_EXPORT NSString* const WHEN_IN_USE_ALERT;
FOUNDATION_EXPORT NSString* const DENIED_ALERT;
FOUNDATION_EXPORT NSString* const RESTRICLET_ALERT;

- (BOOL) startLocationService;

- (void) stopLocationService;

- (void) locationManager:(CLLocationManager*) manager didUpdateLocations:(NSArray*) locations;

- (void) locationManager:(CLLocationManager*) manager didChangeAuthorizationStatus:(CLAuthorizationStatus) status;

- (void) askToChangeAuthorizationStatus:(CLAuthorizationStatus) status;

@end

#endif // LOCATIONSERVICE_H
