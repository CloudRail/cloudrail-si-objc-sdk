//
//  ViewController.h
//  UnifiedSocialProfile
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface ViewController : UIViewController
@property (nonatomic,strong) NSString *serviceName;
@property (nonatomic,strong) id<CRProfileProtocol> service;
@end
