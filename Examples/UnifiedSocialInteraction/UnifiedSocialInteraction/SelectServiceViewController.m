//
//  SelectServiceViewController.m
//  UnifiedSocialInteraction
//
//  Created by CloudRail on 21.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "SelectServiceViewController.h"
#import <CloudrailSI/CloudrailSI.h>
#import "PostUpdatesViewController.h"

@interface SelectServiceViewController ()


@end

@implementation SelectServiceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickFacebook:(id)sender {
    _serviceName = @"Facebook";
}

- (IBAction)clickFacebookpages:(id)sender {
    _serviceName = @"FacebookPages";

}

- (IBAction)clickTwitter:(id)sender {
    _serviceName = @"Twitter";

}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PostUpdatesViewController *controller = (PostUpdatesViewController *)segue.destinationViewController;
    controller.serviceName = _serviceName;
}




@end
