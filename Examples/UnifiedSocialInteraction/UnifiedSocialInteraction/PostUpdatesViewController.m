//
//  PostUpdatesViewController.m
//  UnifiedSocialInteraction
//
//  Created by CloudRail on 21.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "PostUpdatesViewController.h"
#import <CloudrailSI/CloudrailSI.h>

@interface PostUpdatesViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
- (IBAction)postButtonClicked:(id)sender;
- (IBAction)textFieldDidBeginEdit:(id)sender;


@end

@implementation PostUpdatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self login];

}

- (void) login {
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedSocialInteraction", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        if ([_serviceName isEqualToString:@"Facebook"]) {
            _service = [[CRFacebook alloc] initWithClientId:@"[Facebook Client Identifier]"
                                               clientSecret:@"[Facebook Client Secret]"
                                                redirectUri:@"https://www.cloudrailauth.com/auth"
                                                      state:@"someState"
                        ];
        } else if ([_serviceName isEqualToString:@"FacebookPages"]) {
            _service = [[CRFacebookPage alloc] initWithPageName:@"[Facebook Page Identifier]"
                                                       clientId:@"[Facebook Client Identifier]"
                                                   clientSecret:@"[Facebook Client Secret]"
                                                    redirectUri:@"https://www.cloudrailauth.com/auth"
                                                          state:@"someState"
                        ];
        } else if ([_serviceName isEqualToString:@"Twitter"]) {
            _service = [[CRTwitter alloc] initWithClientId:@"[Twitter Client Identifier]"
                                              clientSecret:@"[Twitter Client Secret]"
                                               redirectUri:@"https://www.cloudrailauth.com/auth"
                        ];
        }
        
        
        [_service login];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postButtonClicked:(id)sender {
    NSString *updateText = _textField.text;
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedSocialInteraction", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        [_service postUpdateWithContent:updateText];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //code to be executed on the main thread when background task is finished
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Update posted"
                                                                           message:@"The status update has been posted."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        });
    });
}

- (IBAction)textFieldDidBeginEdit:(id)sender {
}
@end
