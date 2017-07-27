//
//  ShowFilesTableViewController.m
//  UnifiedBucketCloudStorage
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ShowFilesTableViewController.h"

@interface ShowFilesTableViewController ()

@end

@implementation ShowFilesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showFiles];
}

- (void)showFiles {
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedCloudStorage", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        _files = [_service listFilesInBucket:_bucket];
        [self.tableView reloadData];
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CRBusinessFileMetaData *meta = _files[indexPath.row];
    [self downloadFile:[meta fileName]];
}

- (void)downloadFile:(NSString*)fileName {
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedBucketCloudStorage", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        
        NSInputStream* stream = [_service downloadFileWithName:fileName bucket:_bucket];
        NSMutableData* data = [[NSMutableData alloc] init];
        
        uint8_t byteBuffer[4096];
        [stream open];
        while (stream.hasBytesAvailable)
        {
            NSInteger bytesRead = [stream read:byteBuffer maxLength:sizeof(byteBuffer)]; //max len must match buffer size
            [data appendBytes:byteBuffer length:bytesRead];
        }
        NSError *errorWrite = nil;
        NSError *errorCreateDir = nil;
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *downloadsDir = [dirPaths objectAtIndex:0];
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager createDirectoryAtPath:downloadsDir withIntermediateDirectories:YES attributes:nil error:&errorCreateDir];
        if (errorCreateDir != NULL)
            NSLog(@"Create directory returned error: %@", [errorCreateDir localizedDescription]);
        NSString *filePath = [downloadsDir stringByAppendingString:@"/"];
        filePath = [filePath stringByAppendingString:fileName];
        [data writeToFile:filePath options:NSDataWritingAtomic error:&errorWrite];
        if (errorWrite != NULL)
            NSLog(@"Write returned error: %@", [errorWrite localizedDescription]);
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"File downloaded"
                                                                       message:[fileName stringByAppendingString:@" has been downloaded."]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        NSLog(@"%@", downloadsDir);
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
    return [_files count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_files[indexPath.row] fileName];
    
    return cell;
}

@end
