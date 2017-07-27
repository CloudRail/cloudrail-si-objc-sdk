//
//  ViewController.m
//  UnifiedEmailSending
//
//  Created by CloudRail on 27.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) id<CREmailProtocol> service;
@property (weak, nonatomic) IBOutlet UITextField *senerAddressField;
@property (weak, nonatomic) IBOutlet UITextField *senderNameField;
@property (weak, nonatomic) IBOutlet UITextField *receiverAddressField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
- (IBAction)mailjetButtonClicked:(id)sender;
- (IBAction)sendGridButtonClicked:(id)sender;

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

- (IBAction)mailjetButtonClicked:(id)sender {
    _service = [[CRMailJet alloc] initWithClientId:@"[Mailjet API Key]"
                                      clientSecret:@"[Mailjet API Private Key]"
                ];
    [self sendMail];
}

- (IBAction)sendGridButtonClicked:(id)sender {
    _service = [[CRSendGrid alloc] initWithApiKey:@"[SendGrid API Key]"
                ];
    [self sendMail];
}

- (void) sendMail {
    [_service sendEmailFromAddress:_senerAddressField.text
                          fromName:_senderNameField.text
                       toAddresses:[NSMutableArray arrayWithObjects:_receiverAddressField.text, nil]
                           subject:_subjectField.text
                          textBody:_messageField.text
                          htmlBody:_messageField.text
                       ccAddresses:nil
                      bccAddresses:nil
    ];
}

- (void) textViewDidBeginEditing:(UITextView *) textView {
    [textView setText:@""];
}
@end
