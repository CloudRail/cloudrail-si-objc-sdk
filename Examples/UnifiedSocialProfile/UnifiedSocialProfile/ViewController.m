//
//  ViewController.m
//  UnifiedSocialProfile
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelMail;
@property (weak, nonatomic) IBOutlet UILabel *labelBirthdate;
@property (weak, nonatomic) IBOutlet UILabel *labelIdentifier;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_serviceName isEqualToString:@"Facebook"]) {
        _service = [[CRFacebook alloc] initWithClientId:@"[Facebook Client Identifier]"
                                           clientSecret:@"[Facebook Client Secret]"
                                            redirectUri:@"https://www.cloudrailauth.com/auth"
                                                  state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"GitHub"]) {
        _service = [[CRGitHub alloc] initWithClientId:@"[GitHub Client Identifier]"
                                         clientSecret:@"[GitHub Client Secret]"
                                          redirectUri:@"https://www.cloudrailauth.com/auth"
                                                state:@"someState"
                     ];
    } else if ([_serviceName isEqualToString:@"Google+"]) {
        _service = [[CRGooglePlus alloc] initWithClientId:@"[Google Plus Client Identifier]"
                                             clientSecret:@"[Google Plus Client Secret]"
                                              redirectUri:@"https://www.cloudrailauth.com/auth"
                                                    state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Heroku"]) {
        _service = [[CRHeroku alloc] initWithClientId:@"[Heroku Client Identifier]"
                                         clientSecret:@"[Heroku Client Secret]"
                                          redirectUri:@"https://www.cloudrailauth.com/auth"
                                                state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Instagram"]) {
        _service = [[CRInstagram alloc] initWithClientId:@"[Instagram Client Identifier]"
                                            clientSecret:@"[Instagram Client Secret]"
                                             redirectUri:@"https://www.cloudrailauth.com/auth"
                                                   state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"LinkedIn"]) {
        _service = [[CRLinkedIn alloc] initWithClientId:@"[LinkedIn Client Identifier]"
                                           clientSecret:@"[LinkedIn Client Secret]"
                                            redirectUri:@"https://www.cloudrailauth.com/auth"
                                                  state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Product Hung"]) {
        _service = [[CRProductHunt alloc] initWithClientId:@"[Product Hunt Client Identifier]"
                                              clientSecret:@"[Product Hunt Client Secret]"
                                               redirectUri:@"https://www.cloudrailauth.com/auth"
                                                     state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Slack"]) {
        _service = [[CRSlack alloc] initWithClientId:@"[Slack Client Identifier]"
                                        clientSecret:@"[Slack Client Secret]"
                                         redirectUri:@"https://www.cloudrailauth.com/auth"
                                               state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Twitter"]) {
        _service = [[CRTwitter alloc] initWithClientId:@"[Twitter Client Identifier]"
                                          clientSecret:@"[Twitter Client Secret]"
                                           redirectUri:@"https://www.cloudrailauth.com/auth"
                    ];
    } else if ([_serviceName isEqualToString:@"Windows Live"]) {
        _service = [[CRMicrosoftLive alloc] initWithClientId:@"[Windows Live Client Identifier]"
                                                clientSecret:@"[Windows Live Client Secret]"
                                                 redirectUri:@"https://www.cloudrailauth.com/auth"
                                                       state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Yahoo!"]) {
        _service = [[CRYahoo alloc] initWithClientId:@"[Yahoo Client Identifier]"
                                        clientSecret:@"[Yahoo Client Secret]"
                                         redirectUri:@"https://www.cloudrailauth.com/auth"
                                               state:@"someState"
                    ];
    }

    // Do any additional setup after loading the view.
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedSocialProfile", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        [_service login];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateStyle = NSDateFormatterMediumStyle;
            formatter.timeStyle = NSDateFormatterNoStyle;
            
            NSDate * date = [[_service dateOfBirth] date];
            
            formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            NSLog(@"%@", [formatter stringFromDate:date]);
            
            _labelName.text = [_service fullName];
            _labelMail.text = [_service email];
            _labelBirthdate.text = [formatter stringFromDate:date];
            _labelIdentifier.text = [_service identifier];
            
//            NSString * pictrueUrl = [_service pictureURL];
            NSURL * imageURL = [NSURL URLWithString:[_service pictureURL]];
            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage * image = [UIImage imageWithData:imageData];
            
            [_imageView setImage:image];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
