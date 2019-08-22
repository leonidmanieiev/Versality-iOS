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

#ifndef APPDELEGATE_H
#define APPDELEGATE_H

extern "C"

#include <UIKit/UIKit.h>
#include <QtCore>
#include "locationService.h"

@interface QIOSApplicationDelegate : UIResponder <UIApplicationDelegate> {
    LocationService* locationService;
}

@property (strong, nonatomic) UIWindow *window;

FOUNDATION_EXPORT NSString* const SLCM_IS_UNAVAILABLE;
//FOUNDATION_EXPORT NSString* const ENABLE_BG_CAPABILITIES;

// helps handle promotion opening via push tap
extern bool initLaunch;

- (void) initLocationService;

//- (void) askToEnableBackgroundCapabilities;

- (void) slcmIsUnavailable;

- (void) openPromotion:(NSString*) promotionId;

@end

#endif // APPDELEGATE_H
