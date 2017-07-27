//
//  ViewController.m
//  UnifiedSMSSending
//
//  Created by CloudRail on 27.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) id<CRSMSProtocol> service;
@property (weak, nonatomic) IBOutlet UITextField *fromField;
@property (weak, nonatomic) IBOutlet UITextField *toField;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
- (IBAction)buttonClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textViewDidBeginEditing:(UITextView *) textView {
    [textView setText:@""];
}

- (IBAction)buttonClick:(id)sender {
    switch ([sender tag]) {
        case 1:
            _service = [[CRNexmo alloc] initWithClientId:@"[Nexmo API Key]"
                                            clientSecret:@"[Nexmo API Secret]"];
            break;
        case 2:
            _service = [[CRTwilio alloc] initWithAccountSid:@"[Twilio Account SID]"
                                                  authToken:@"[Twilio Auth Token]"];
            break;
        case 3:
            _service = [[CRTwizo alloc] initWithKey:@"[Twizo Key]"];
            break;
        default:
            break;
    }
    
    [_service sendSmsFromName:_fromField.text
                     toNumber:_toField.text
                      content:_messageField.text
     ];
}
@end
