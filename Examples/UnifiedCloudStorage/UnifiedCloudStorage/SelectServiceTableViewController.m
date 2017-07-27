//
//  SelectServiceTableViewController.m
//  UnifiedCloudStorage
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "SelectServiceTableViewController.h"
#import "ShowFilesTableViewController.h"

@interface SelectServiceTableViewController ()

@end

@implementation SelectServiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _serviceNames = @[@"box", @"Dropbox", @"Egnyte", @"Google Drive", @"OneDrive", @"OneDrive for Business"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _serviceNames[indexPath.row];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"serviceChosen"]) {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        ShowFilesTableViewController *destViewController = (ShowFilesTableViewController *)segue.destinationViewController;
        destViewController.serviceName = _serviceNames[indexPath.row];
        destViewController.currentPath = @"/";
    }
}


@end
