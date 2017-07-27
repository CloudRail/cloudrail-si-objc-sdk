//
//  TableViewController.m
//  UnifiedSocialProfile
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"

@interface TableViewController ()
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _serviceNames = @[@"Facebook", @"GitHub", @"Google+", @"Heroku", @"Instagram", @"LinkedIn", @"Product Hunt", @"Slack", @"Twitter", @"Windows Live", @"Yahoo!"];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"goToProfile"]) {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        ViewController *destViewController = (ViewController *)segue.destinationViewController;
        destViewController.serviceName = _serviceNames[indexPath.row];
        
    }
}

@end
