//
//  CloudStorageViewController.m
//  CloudRail-SI-iOS
//
//  Created by Felipe Cesar on 15/06/16.
//  Copyright © 2016 Felipe Cesar. All rights reserved.
//

#import "CloudStorageViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define kIMG_URL @"https://imgflip.com/s/meme/Futurama-Fry.jpg"
#define kUPLOAD_PATH @"/futurama.jpg"

@interface CloudStorageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CloudStorageViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeService];
  
    //Downloading and set imageView
    NSURL *url = [NSURL URLWithString:kIMG_URL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    self.imageView.image = image;
}

- (void)initializeService {
    
  // Note: these are sample test keys/secrets that show not be used for production
  NSDictionary * authDic = @{
                             @"dropboxKey" : @"38nu3lwdvyaqs78",
                             @"dropboxSecret" : @"c95g0wfkdv6ua2d",
                             @"googledriveKey" : @"638240013795-4nunsen5ada95kll9u18dpu1ocrt6nur.apps.googleusercontent.com",
                             @"googledriveSecret" : @"",
                             @"boxKey" : @"qnskodzvd2naq16xowc40t43fug2848n",
                             @"boxSecret" : @"cQE7Sf9DzZqChjvCTxIMTp3ye6hynhTd",
                             @"onedriveKey" : @"000000004018F12F",
                             @"onedriveSecret" : @"lGQPubehDO6eklir1GQmIuCPFfzwihMo",
                             @"egnyteKey" : @"k9y879bha2kmsyyqx4urtnaz",
                             @"egnyteSecret" : @"TsgByd2YZqsJPyYMDhEB6ctAYQ6kP35qYTnEG9urPKq2eNNXRF",
                             @"egnyteDomain" : @"cloudrailcloudtest"
                             };
  
  NSString * key = [[self.serviceName lowercaseString] stringByAppendingString:@"Key"];
  NSString * secret = [[self.serviceName lowercaseString] stringByAppendingString:@"Secret"];
  
  self.serviceName = [@"CR" stringByAppendingString:self.serviceName];
 
  if ([self.serviceName isEqualToString:@"CRDropbox"]) {
    self.service = [[CRDropbox alloc] initWithClientId:authDic[key] clientSecret:authDic[secret]];
  } else if ([self.serviceName isEqualToString:@"CRGoogleDrive"]) {
    CRGoogleDrive * drive = [[CRGoogleDrive alloc] initWithClientId:authDic[key]
                                                      clientSecret:authDic[secret]
                                                       redirectUri:@"org.cocoapods.demo.CloudRail-SI-iOS-Example:/oauth2redirect"
                                                             state:@"efwegwww"];
    [drive useAdvancedAuthentication];
    self.service = drive;
  } else if ([self.serviceName isEqualToString:@"CRBox"]) {
    self.service = [[CRBox alloc] initWithClientId:authDic[key] clientSecret:authDic[secret]];
  } else if ([self.serviceName isEqualToString:@"CROneDrive"]) {
    self.service = [[CROneDrive alloc] initWithClientId:authDic[key] clientSecret:authDic[secret]];
  } else if ([self.serviceName isEqualToString:@"CREgnyte"]) {
    self.service = [[CREgnyte alloc] initWithDomain:authDic[@"egnyteDomain"] clientId:authDic[key] clientSecret:authDic[secret] redirectUri:@"https://www.cloudrailauth.com/auth" state:@"STATE"];
  }
}

#pragma mark - Actions Methods

- (IBAction)createShareLink:(id)sender {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"futurama" ofType:@"jpg"];
    
    NSString *link = [self.service shareLinkForFileWithPath:path];
    NSString *userName = [self.service userName];
    NSString *userLogin = [self.service userLogin];
    
    NSString *message = [NSString stringWithFormat:@"Username: %@\n Login: %@\n Share Link:%@", userName , userLogin, link];
    
    //Presenting Alert View
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Share Link"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction * yesButton = [UIAlertAction
                                 actionWithTitle:@"Copy Link"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                                     pasteboard.string = link;
                                 }];
  
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)spaceAllocationAction:(id)sender {
  
    CRSpaceAllocation * spaceAllocation = [self.service spaceAllocation];
  
    //Presenting Alert View
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Space Allocation"
                                 message:spaceAllocation.description
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * noButton = [UIAlertAction
                                actionWithTitle:@"Close"
                                style:UIAlertActionStyleDefault
                                handler:nil];
  
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)uploadDefault:(id)sender {
  UIImage * image = self.imageView.image;
  
  NSData * imageData = UIImageJPEGRepresentation(image, 1);
  NSInputStream * inputStream = [NSInputStream inputStreamWithData:imageData];
  [self.service uploadFileToPath:kUPLOAD_PATH withStream:inputStream size:imageData.length overwrite:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
  [picker dismissViewControllerAnimated:YES completion:^{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
      //Background Thread to not block the app while authenticating
      UIImage * image = info[UIImagePickerControllerEditedImage];
      NSData * imageData = UIImageJPEGRepresentation(image, 1);
      NSInputStream * inputStream = [NSInputStream inputStreamWithData:imageData];
      [self.service uploadFileToPath:kUPLOAD_PATH withStream:inputStream size:imageData.length overwrite:YES];
    });
  }];
}

- (IBAction)uploadFromCamera:(id)sender {
  
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
  } else {
      
    //Presenting Alert View
    UIAlertController * alert = [UIAlertController
                                alertControllerWithTitle:@"Error accessing Camera"
                                message:@"Simulator cannot use this feature"
                                preferredStyle:UIAlertControllerStyleAlert];
      
    UIAlertAction * okButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:nil];
      
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
  }
}

- (IBAction)uploadFromCameraRoll:(id)sender {
  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.allowsEditing = YES;
  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  [self presentViewController:picker animated:YES completion:NULL];
}

@end
