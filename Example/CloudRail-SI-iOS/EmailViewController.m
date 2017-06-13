//
//  EmailViewController.m
//  CloudRail_ServiceCode
//
//  Created by Felipe Cesar on 23/06/16.
//  Copyright © 2016 CloudRail. All rights reserved.
//

#import "EmailViewController.h"

@implementation EmailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSDictionary * authDic = @{
                             @"mailjetKey" : @"c33840d7698d32862e5f2d837e1ae9dd",
                             @"mailjetSecret" : @"4f58b437a4b6964a2ccafc5f133a6a84",
                             
                             @"sendgridKey" : @"",
                             };
  
  NSString * key = [[self.serviceName lowercaseString] stringByAppendingString:@"Key"];
  NSString * secret = [[self.serviceName lowercaseString] stringByAppendingString:@"Secret"];
  
  if ([self.serviceName isEqualToString:@"MailJet"]) {
      self.service = [[CRMailJet alloc] initWithClientId:authDic[key] clientSecret:authDic[secret]];
  } else if ([self.serviceName isEqualToString:@"SendGrid"]) {
      
      if ([authDic[key] isEqualToString:@""]) {
          UIAlertController * alert = [UIAlertController
                                       alertControllerWithTitle:@"SendGrid Key Required"
                                       message:@"Please enter SendGridAPI Key"
                                       preferredStyle:UIAlertControllerStyleAlert];
          
          UIAlertAction * noButton = [UIAlertAction
                                      actionWithTitle:@"Ok"
                                      style:UIAlertActionStyleDefault
                                      handler:nil];
          
          [alert addAction:noButton];
          [self presentViewController:alert animated:YES completion:nil];
      } else {
          self.service = [[CRSendGrid alloc] initWithApiKey:authDic[key]];
      }
  }
}

#pragma mark - Action Methos (Send Email)

- (IBAction)sendEmail:(id)sender {
    [self.service sendEmailFromAddress:@"felipe.cesar+mailjet@cloudrail.com" fromName:@"Bob Bauer" toAddresses:[@[@"fel.cesar@gmail.com"] mutableCopy] subject:@"Felipe" textBody:@"This email was sent using it! \n\r" htmlBody:@"" ccAddresses:[@[]mutableCopy] bccAddresses:[@[] mutableCopy]];

}

@end
