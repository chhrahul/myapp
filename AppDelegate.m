/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  PusherCordova
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//
@import UserNotifications;
#import "PusherSwift/PusherSwift-Swift.h"


#import "AppDelegate.h"
#import "MainViewController.h"
@interface AppDelegate ()
    
    @property (nonatomic, retain, readwrite) Pusher *pusher;
    
    @end
@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.viewController = [[MainViewController alloc] init];
    
    self.pusher = [[Pusher alloc] initWithKey:@"e80bb52b71fa4101c22f"];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        // Enable or disable features based on authorisation.
    }];
    
    [application registerForRemoteNotifications];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
  
}
    
    - (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
        NSLog(@"Registered for remote notifications; received device token");
        [[[self pusher] nativePusher] registerWithDeviceToken:deviceToken];
        [[[self pusher] nativePusher] subscribeWithInterestName:@"cordova"];
    }
    - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
        NSLog(@"Received remote notification: %@", userInfo);
    }
    @end
