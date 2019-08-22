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

#include "logger.h"
#include <QtCore>
//#import <OneSignal/OneSignal.h>

@implementation Logger

- (void) log:(NSString*) str
{
    NSString* timedStr = [[self currectTime] stringByAppendingString:str];
    NSData* data = [timedStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSLog(@"%@", timedStr);
    [self sendLog:str];

    if (0 < [paths count])
    {
        NSString* documentsDirPath = [paths objectAtIndex:0];
        NSString* filePath = [documentsDirPath stringByAppendingPathComponent:@"log.txt"];
        NSFileManager* fileManager = [NSFileManager defaultManager];

        if ([fileManager fileExistsAtPath:filePath]) {
            // Add the text at the end of the file.
            NSFileHandle* fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
            [fileHandler seekToEndOfFile];
            [fileHandler writeData:data];
            [fileHandler closeFile];
        } else {
            // Create the file and write text to it.
            [data writeToFile:filePath atomically:YES];
        }
    }
}

- (void) sendLog:(NSString*) log
{
    NSString* userHash = [self getHashFromFile];
    NSString* sendLogAPI = @"https://club.versality.ru/api/logs?secret=";

    if(userHash == nil) {
        NSLog(@"userHash is null");
        return;
    }

    NSString* url = [sendLogAPI stringByAppendingString:userHash];
    url = [url stringByAppendingString:@"&log="];
    url = [url stringByAppendingString:log];

    UIBackgroundTaskIdentifier bgTask = UIBackgroundTaskInvalid;
    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }];

    if([self httpGetRequest:url]) {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }
}

- (void) sendCoords:(double) lat :(double) lon
{
    NSString* coords = [NSString stringWithFormat:@"&lat=%f&lon=%f", lat, lon];
    NSString* userHash = [self getHashFromFile];
    NSString* sendCoordsAPI = @"https://club.versality.ru:8080/api/check?secret=";

    if(userHash == nil) {
        [self log:@"sendCoords::userHash is null\n"];
        return;
    }

    NSString* url = [sendCoordsAPI stringByAppendingString:userHash];
    url = [url stringByAppendingString:coords];

    UIBackgroundTaskIdentifier bgTask = UIBackgroundTaskInvalid;
    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }];

    if([self httpGetRequest:url]) {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }
}

- (bool) httpGetRequest:(NSString*) url
{
    if (@available(iOS 10.0, *)) {
        __block long status = -1;
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL* ns_url = [NSURL URLWithString: url];
        NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:ns_url];
        [urlRequest setHTTPMethod:@"GET"];

        NSURLSession* session = [NSURLSession sharedSession];
        NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:urlRequest completionHandler:
            ^(NSData* __unused data, NSURLResponse* response, NSError* __unused error) {
                NSHTTPURLResponse* httpResponse = static_cast<NSHTTPURLResponse*>(response);
                NSLog(@"http status code: %ld", httpResponse.statusCode);
                status = httpResponse.statusCode;
            }];
        [dataTask resume];

        return status == 200;
    } else {
        // minimum required iOS version - 10.0 (only 1% use < 10.0)
        exit(1);
    }
}

- (void) saveHashToFile:(NSString*) userHash
{
    //[OneSignal sendTag:@"hash" value:userHash];
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"hash.txt"];
    [userHash writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString*) getHashFromFile
{
    UIBackgroundTaskIdentifier bgTask = UIBackgroundTaskInvalid;
    bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }];

    NSString* userHash = nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"hash.txt"];
    userHash = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

    if(userHash != nil) {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    }

    return userHash;
}

- (NSString*) currectTime
{
    NSDate* now = [NSDate date];
    NSDateFormatter* outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd.MM.yyyy HH:mm:ss: "];
    NSString* currTime = [outputFormatter stringFromDate:now];

    [outputFormatter release];
    return currTime;
}

+ (Logger*) sharedSingleton
{
    static Logger* sharedSingleton = nil;

    if(!sharedSingleton)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedSingleton = [Logger new];
        });
    }

    return sharedSingleton;
}

@end
