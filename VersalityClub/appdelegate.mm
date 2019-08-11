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

#import "appdelegate.h"
#import "logger.h"

@implementation QIOSApplicationDelegate

NSString* const SLCM_IS_UNAVAILABLE    = @"Извините, Вы не сможете получать push-уведомления, потому что у приложения нет доступа к Вашей геопозиции.";
NSString* const ENABLE_BG_CAPABILITIES = @"Пожалуйста, включите «Обновление контента».\nЕсли оно уже включено, перейдите в «Настройки -> Основные -> Обновление контента» и включите его там.";

- (BOOL)application:(UIApplication *) __unused application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions
{
    if (@available(iOS 10.0, *)) {        
        if(locationService == nil) {
            locationService = [[LocationService alloc] init];
        }

        if(launchOptions[UIApplicationLaunchOptionsLocationKey]) {
            [self initLocationService];
        }

        return YES;
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        [[Logger sharedSingleton] log:@"minimum required iOS version - 10.0\n"];
        exit(1);
    }
}

- (void)applicationDidEnterBackground:(UIApplication *) __unused application {
    [self initLocationService];
}

- (void)applicationDidBecomeActive:(UIApplication *) __unused application {
    [locationService stopLocationService];

    if (@available(iOS 10.0, *)) {
        if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied) {
            [self askToEnableBackgroundCapabilities];
        }

        if(![CLLocationManager significantLocationChangeMonitoringAvailable]) {
            [self slcmIsUnavailable];
        }
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (void)applicationWillTerminate:(UIApplication *) __unused application {
    [self initLocationService];
}

- (void) initLocationService
{
    if(locationService.startLocationService)
        [[Logger sharedSingleton] log:@"Location service started\n"];
}

- (void) askToEnableBackgroundCapabilities
{
    if (@available(iOS 10.0, *)) {
        NSURL* settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        UIViewController* rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;

        UIAlertController* alert =
            [UIAlertController alertControllerWithTitle:@"Внимание"
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

        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Закрыть приложение"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction* __unused action) { exit(1); }];

        [alert addAction:settingsAction];
        [alert addAction:cancelAction];
        [rootViewController presentViewController:alert animated:YES completion:nil];
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (void) slcmIsUnavailable
{
    if (@available(iOS 10.0, *)) {
        UIViewController* rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;

        UIAlertController* alert =
            [UIAlertController alertControllerWithTitle:@"Внимание"
                                                message:SLCM_IS_UNAVAILABLE
                                         preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Закрыть приложение"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction* __unused action) { exit(1); }];

        [alert addAction:cancelAction];
        [rootViewController presentViewController:alert animated:YES completion:nil];
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

@end
