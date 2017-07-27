//
//  ChargesTableViewController.m
//  UnifiedPayment
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ChargesTableViewController.h"

@interface ChargesTableViewController ()
- (IBAction)onAddChargeClicked:(id)sender;

@end

@implementation ChargesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_service == NULL) {
        if ([_serviceName isEqualToString:@"PayPal"]) {
            _service = [[CRPayPal alloc] initWithUseSandbox:true
                                                   clientId:@"AWW6zTBEkFz4ridW1QgMIg2-KqpR0Ww04d3nf-rooW97B_c9b09Nt3iynL7GKHB1_7rN39oWMB4Sui0c"
                                               clientSecret:@"EIJQze3Ykgu56ajtf8mq8q0dUNqC9-kRCUPvHqakO0r-UkTdRy91hs_kOaj06ZYLYU-WmkO4n0qqQbUB"
                        ];
        } else if ([_serviceName isEqualToString:@"Stripe"]) {
            _service = [[CRStripe alloc] initWithSecretKey:@"sk_test_AavUPoLur3i2XwEMZjRYnpmb"];
        }
    }
    
    [self getCharges];
}

- (void)getCharges {
    int now = [[NSDate date] timeIntervalSince1970];
    int oneYearAgo = now - (3600*24*365);
    _charges = [_service listChargesFrom:[NSNumber numberWithInteger:oneYearAgo] to:[NSNumber numberWithInteger:now] creditCard:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_charges count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CRCharge *charge = _charges[indexPath.row];
    NSNumber *amount = @([[charge amount] floatValue] / 100);
    cell.textLabel.text = [[amount stringValue] stringByAppendingString:[charge currency]];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[charge created]doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    cell.detailTextLabel.text = [formatter stringFromDate:date];
    
    return cell;
}

- (IBAction)onAddChargeClicked:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"New Charge"
                                                                              message: @"Create a new Charge:"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Amount";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Currency";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray *textfields = alertController.textFields;
        UITextField *amountfield = textfields[0];
        UITextField *currencyfield = textfields[1];
        NSString *amountstring = amountfield.text;
        NSNumber *amount = @([amountstring integerValue]);
        NSString *currency = currencyfield.text;
        
        CRAddress *address = [[CRAddress alloc] init];
        CRCreditCard *source = [CRCreditCard alloc];
        [source initWithCvc:@"123"
                expireMonth:[NSNumber numberWithInt:12]
                 expireYear:[NSNumber numberWithInt:2020]
                     number:@"4242424242424242"
                       type:@"visa"
                  firstName:@"Jon"
                   lastName:@"Doe"
                    address:address
         ];
        NSLog(@"amount = %@", amount);
        NSLog(@"currency = %@", currency);
        [_service createChargeWithAmount:amount
                                currency:currency
                                  source:source
         ];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCharge"]) {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        ChargeDetailViewController *destViewController = (ChargeDetailViewController *)segue.destinationViewController;
        destViewController.service = _service;
        destViewController.charge = _charges[indexPath.row];
    }
}

@end
