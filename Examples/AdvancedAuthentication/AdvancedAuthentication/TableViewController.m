//
//  TableViewController.m
//  AdvancedAuthentication
//
//  Created by CloudRail on 03.08.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _googleDrive = [[CRGoogleDrive alloc] initWithClientId:@"[Google Drive Client ID]"
                                              clientSecret:@""
                                               redirectUri:@"com.cloudrail.AdvancedAuthentication:/oauth2redirect"
                                                     state:@"someState"
                    ];
    [_googleDrive useAdvancedAuthentication];
    
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedCloudStorage", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        _files = [_googleDrive childrenOfFolderWithPath:@"/"];
        dispatch_async(dispatch_get_main_queue(), ^{
            //code to be executed by the UI thread
            [self.tableView reloadData];
        });
    });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [_files count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_files[indexPath.row] name];
    
    return cell;
}

@end
