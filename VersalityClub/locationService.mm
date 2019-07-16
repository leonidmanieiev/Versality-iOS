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

#import "locationService.h"
#import "logger.h"
#import <UIKit/UIKit.h>

@implementation LocationService

NSString* const WHEN_IN_USE_ALERT = @"With location access set to 'While Using the App' we can't send you push notifications. Please, switch it to 'Always'.";
NSString* const DENIED_ALERT      = @"With location access set to 'Never' we can't start the App. Please switch it to 'Always'.";
NSString* const RESTRICLET_ALERT  = @"Sorry. We can't start App without location access set to 'Always'.";

- (id) init
{
    if (@available(iOS 10.0, *)) {
        self = [super init];
        self->locationManager = [[CLLocationManager alloc] init];
        [self->locationManager requestAlwaysAuthorization];
        self->locationManager.delegate = self;
        self->locationManager.allowsBackgroundLocationUpdates = YES;
        self->locationManager.pausesLocationUpdatesAutomatically = NO;

        [[Logger sharedSingleton] log:@"init LocationService\n"];
        return self;
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (BOOL) startLocationService
{
    if (@available(iOS 10.0, *)) {
        if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            return NO;
        }

        [[Logger sharedSingleton] log:@"startMonitoringSignificantLocationChanges\n"];
        [self->locationManager startMonitoringSignificantLocationChanges];
        return YES;
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (void) stopLocationService
{
    [[Logger sharedSingleton] log:@"stopMonitoringSignificantLocationChanges\n"];
    [self->locationManager stopMonitoringSignificantLocationChanges];
}

- (void) locationManager:(CLLocationManager*) __unused manager didUpdateLocations:(NSArray*) locations
{
    CLLocation* location = [locations lastObject];
    double lat = location.coordinate.latitude;
    double lon = location.coordinate.longitude;
    NSString* coords = [NSString stringWithFormat:@"lat: %f | lon: %f\n", lat, lon];

    if(fabs(location.timestamp.timeIntervalSinceNow) < 60) {
        [[Logger sharedSingleton] log:[@"valid: " stringByAppendingString:coords]];
        [[Logger sharedSingleton] sendCoords :lat :lon];
    } else {
        [[Logger sharedSingleton] log:[@"invalid: " stringByAppendingString:coords]];
    }
}

- (void) locationManager:(CLLocationManager*) __unused manager didChangeAuthorizationStatus:(CLAuthorizationStatus) status
{
    if (@available(iOS 10.0, *)) {
        if(status != kCLAuthorizationStatusAuthorizedAlways) {
            [self askToChangeAuthorizationStatus:status];
        }
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (void) askToChangeAuthorizationStatus:(CLAuthorizationStatus) status
{
    if (@available(iOS 10.0, *)) {
        NSURL* settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        UIViewController* rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;

        UIAlertController* alert =
            [UIAlertController alertControllerWithTitle:@"Alert"
                                                message:@""
                                         preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* settingsAction
            = [UIAlertAction actionWithTitle:@"Settings"
                                       style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction* __unused action) {
                                         if ([[UIApplication sharedApplication] canOpenURL:settingsUrl]) {
                                             [[UIApplication sharedApplication] openURL:settingsUrl options:@{} completionHandler:nil];
                                         }
                                     }];

        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancle"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction* __unused action) { exit(1); }];

        [alert addAction:settingsAction];
        [alert addAction:cancelAction];

        switch (status)
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
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

@end
