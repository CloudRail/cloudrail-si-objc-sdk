//
//  ServiceSelectTableViewController.m
//  UnifiedPayment
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ServiceSelectTableViewController.h"

@interface ServiceSelectTableViewController ()

@end

@implementation ServiceSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _serviceNames = @[@"PayPal", @"Stripe"];
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
    return [_serviceNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _serviceNames[indexPath.row];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"serviceSelected"]) {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        ChargesTableViewController *destViewController = (ChargesTableViewController *)segue.destinationViewController;
        destViewController.serviceName = _serviceNames[indexPath.row];
    }
}


@end
