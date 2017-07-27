//
//  PostUpdatesViewController.h
//  UnifiedSocialInteraction
//
//  Created by CloudRail on 21.07.17./Users/cloudrail/Documents/cloudrail-si-ios-sdk/Examples/UnifiedSocialInteraction/UnifiedSocialInteraction/PostUpdatesViewController.m
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface PostUpdatesViewController : UIViewController
@property(nonatomic,strong) id<CRSocialProtocol> service;
@property(nonatomic,strong) NSString *serviceName;

@end
