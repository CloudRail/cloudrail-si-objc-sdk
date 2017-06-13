//
//  CRAppDelegate.m
//  CloudRail-SI-iOS
//
//  Created by Felipe Cesar on 05/24/2016.
//  Copyright (c) 2016 Felipe Cesar. All rights reserved.
//

#import "CRAppDelegate.h"
#import <CloudRailSI/CloudRailSI.h>

#define kCLOUDRAIL_KEY @"592570de40ec7664ba40a4e5"

@implementation CRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([kCLOUDRAIL_KEY isEqualToString:@""]) {
        NSLog(@"No Cloudrail Key found");
    } else {
        [CRCloudRail setAppKey:kCLOUDRAIL_KEY];
    }
    
    return YES;
}

// Used for AdvancedAuthentication
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kCloseSafariViewControllerNotification" object:url];
  return YES;
}

@end
