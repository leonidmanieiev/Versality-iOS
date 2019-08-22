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

#include "enablelocation.h"
#include <QtCore>

@implementation EnableLocation

NSString* const ENABLE_BG_CAPABILITIES = @"Если Вы хотите получать уведомления об акциях поблизости, включите «Обновление контента».\nЕсли оно уже включено, перейдите в «Настройки -> Основные -> Обновление контента» и включите его там.";
NSString* const WHEN_IN_USE_ALERT = @"Если Вы хотите получать уведомления об акциях поблизости, переключите режим геопозиции с «Только при использовании» на «Всегда».";
NSString* const DENIED_ALERT      = @"Если Вы хотите получать уведомления об акциях поблизости, переключите режим геопозиции с «Запретить» на «Всегда».";
NSString* const RESTRICLET_ALERT  = @"Если Вы хотите получать уведомления об акциях поблизости, переключите режим геопозиции на «Всегда».";
NSString* const NA_DENIED_ALERT  = @"Для доступа к этой функции приложения включите геопозицию.";

- (BOOL) askEnableLocationAlways
{
    if (@available(iOS 10.0, *)) {
        if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            NSURL* settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            UIViewController* rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;

            UIAlertController* alert =
                [UIAlertController alertControllerWithTitle:@""
                                                    message:@""
                                             preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* settingsAction
                = [UIAlertAction actionWithTitle:@"Настройки"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction* __unused action) {
                                             if ([[UIApplication sharedApplication] canOpenURL:settingsUrl]) {
                                                 [[UIApplication sharedApplication] openURL:settingsUrl options:@{} completionHandler:nil];
                                             }
                                         }];

            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Отменить"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction* __unused action) {  }];

            [alert addAction:settingsAction];
            [alert addAction:cancelAction];

            switch ([CLLocationManager authorizationStatus])
            {
                case kCLAuthorizationStatusAuthorizedWhenInUse:
                    alert.message = WHEN_IN_USE_ALERT;
                    [rootViewController presentViewController:alert animated:YES completion:nil];
                    break;
                case kCLAuthorizationStatusDenied:
                    alert.message = DENIED_ALERT;
                    [rootViewController presentViewController:alert animated:YES completion:nil];
                    break;
                case kCLAuthorizationStatusRestricted:
                    alert.message = RESTRICLET_ALERT;
                    [rootViewController presentViewController:alert animated:YES completion:nil];
                    break;
                default: break;
            }

            return NO;
        } else {
            return YES;
        }
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (BOOL) askEnableLocation
{
    if (@available(iOS 10.0, *)) {
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
           [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
            NSURL* settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            UIViewController* rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;

            UIAlertController* alert =
                [UIAlertController alertControllerWithTitle:@""
                                                    message:NA_DENIED_ALERT
                                             preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* settingsAction =
                [UIAlertAction actionWithTitle:@"Настройки"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction* __unused action) {
                                           if ([[UIApplication sharedApplication] canOpenURL:settingsUrl]) {
                                               [[UIApplication sharedApplication] openURL:settingsUrl options:@{} completionHandler:nil];
                                           }
                                       }];

            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Отменить"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction* __unused action) {  }];

            [alert addAction:settingsAction];
            [alert addAction:cancelAction];
            [rootViewController presentViewController:alert animated:YES completion:nil];
            return NO;
        } else {
            return YES;
        }
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (BOOL) askEnableBR
{
    if (@available(iOS 10.0, *)) {
        if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied) {

            NSURL* settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            UIViewController* rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;

            UIAlertController* alert =
                [UIAlertController alertControllerWithTitle:@""
                                                    message:ENABLE_BG_CAPABILITIES
                                             preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* settingsAction
                = [UIAlertAction actionWithTitle:@"Настройки"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction* __unused action) {
                                             if ([[UIApplication sharedApplication] canOpenURL:settingsUrl]) {
                                                 [[UIApplication sharedApplication] openURL:settingsUrl options:@{} completionHandler:nil];
                                             }
                                         }];

            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Отменить"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction* __unused action) {  }];

            [alert addAction:settingsAction];
            [alert addAction:cancelAction];
            [rootViewController presentViewController:alert animated:YES completion:nil];
            return NO;
        } else {
            return YES;
        }
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

+ (EnableLocation*) sharedSingleton
{
    static EnableLocation* sharedSingleton = nil;

    if(!sharedSingleton)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedSingleton = [EnableLocation new];
        });
    }

    return sharedSingleton;
}

@end
