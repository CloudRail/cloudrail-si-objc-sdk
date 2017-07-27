//
//  ChargeDetailViewController.m
//  UnifiedPayment
//
//  Created by CloudRail on 27.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ChargeDetailViewController.h"

@interface ChargeDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *refundsLabel;
- (IBAction)refundButtonClicked:(id)sender;

@end

@implementation ChargeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateLabels {
    //code to be executed in the background
    NSNumber *amount = [NSNumber numberWithFloat:([[_charge amount]floatValue] / 100)];
    _amountLabel.text = [[amount stringValue] stringByAppendingString:[_charge currency]];
    _idLabel.text = [_charge identifier];
    _nameLabel.text = [[[[_charge source] firstName] stringByAppendingString:@" "] stringByAppendingString:[[_charge source] lastName]];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[_charge created]doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    _timeLabel.text = [formatter stringFromDate:date];
    
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedPayment", NULL);
    dispatch_async(queue, ^{
        NSMutableArray<CRRefund*> *refunds = [_service refundsForChargeWithIdentifier:[_charge identifier]];
        NSNumber *totalRefunds = [NSNumber numberWithInt:0];
        for (CRRefund *refund in refunds) {
            totalRefunds = [NSNumber numberWithFloat:([totalRefunds floatValue] + [[refund amount] floatValue] / 100)];
        }
        NSString *refundsString = [totalRefunds stringValue];
        if (refundsString == nil) {
            refundsString = @"0";
        }
        refundsString = [refundsString stringByAppendingString:[_charge currency]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //code to be executed by the UI thread
            _refundsLabel.text = refundsString;
        });
    });
}

- (IBAction)refundButtonClicked:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Add refund"
                                                                              message: @"Create a refund for the selected charge:"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Amount (for partial refund)";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Partially refund" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray *textfields = alertController.textFields;
        UITextField *amountfield = textfields[0];
        NSString *amountstring = amountfield.text;
        NSNumber *amount = @([amountstring integerValue]);
        dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedPayment", NULL);
        dispatch_async(queue, ^{
            [_service partiallyRefundChargeWithIdentifier:[_charge identifier] amount:amount];
            _charge = [_service chargeWithIdentifier:[_charge identifier]];
            [self updateLabels];
        });
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Fully refund" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedPayment", NULL);
        dispatch_async(queue, ^{
            [_service refundChargeWithIdentifier:[_charge identifier]];
            _charge = [_service chargeWithIdentifier:[_charge identifier]];
            [self updateLabels];
        });
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
