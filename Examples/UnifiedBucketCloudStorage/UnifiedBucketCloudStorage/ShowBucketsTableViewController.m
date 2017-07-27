//
//  ShowBucketsTableViewController.m
//  UnifiedBucketCloudStorage
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ShowBucketsTableViewController.h"

@interface ShowBucketsTableViewController ()

@end

@implementation ShowBucketsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initService];
    [self getBuckets];
}

- (void)initService{
    if ([_serviceName isEqualToString:@"Amazon Web Services S3"]) {
        _service = [[CRAmazonS3 alloc] initWithAccessKeyId:@"[Your S3 Access Key ID]"
                                           secretAccessKey:@"[Your S3 Secret Access Key]"
                                                    region:@"[Your AWS region]"
                    ];
    } else if ([_serviceName isEqualToString:@"Backblaze"]) {
        _service = [[CRBackblaze alloc] initWithAccountID:@"[Your Backblaze Account ID]"
                                                   appKey:@"[Your Backblaze App Key]"
                    ];
    } else if ([_serviceName isEqualToString:@"Google Cloud Platform"]) {
        _service = [[CRGoogleCloudPlatform alloc] initWithClientEmail:@"[Your Google Client Email]"
                                                           privateKey:@"[Your Google Private Key]"
                                                            projectId:@"[Your Google Project ID]"
                    ];
    } else if ([_serviceName isEqualToString:@"Microsoft Azure Storage"]) {
        _service = [[CRMicrosoftAzure alloc] initWithAccountName:@"[Your Azure Account Name]"
                                                       accessKey:@"[Your Azure Access Key]"
                    ];
    } else if ([_serviceName isEqualToString:@"Rackspace"]) {
        _service = [[CRRackspace alloc] initWithUsername:@"[Your Rackspace User Name]"
                                                  apiKey:@"[Your Rackspace API Key]"
                                                  region:@"[Your Rackspace Region]"
                    ];
    }
}

- (void) getBuckets {
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedCloudStorage", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        _buckets = [_service listBuckets];
        [self.tableView reloadData];
    });
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
    return [_buckets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_buckets[indexPath.row] name];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"bucketChosen"]) {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        ShowFilesTableViewController *destViewController = (ShowFilesTableViewController *)segue.destinationViewController;
        destViewController.service = _service;
        destViewController.bucket = _buckets[indexPath.row];
    }
}


@end
