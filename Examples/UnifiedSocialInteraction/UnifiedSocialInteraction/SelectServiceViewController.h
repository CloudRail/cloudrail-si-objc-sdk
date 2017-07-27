//
//  SelectServiceViewController.h
//  UnifiedSocialInteraction
//
//  Created by CloudRail on 21.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface SelectServiceViewController : UIViewController
@property(nonatomic) NSString *serviceName;
- (IBAction)clickFacebook:(id)sender;
- (IBAction)clickFacebookpages:(id)sender;
- (IBAction)clickTwitter:(id)sender;

@end
