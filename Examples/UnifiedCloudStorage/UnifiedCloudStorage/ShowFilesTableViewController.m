//
//  ShowFilesTableViewController.m
//  UnifiedCloudStorage
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "ShowFilesTableViewController.h"

@interface ShowFilesTableViewController ()

@end

@implementation ShowFilesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_service == nil) {
        [self initService];
    } else {
        [self getFiles];
    }
}

- (void)initService{
    if ([_serviceName isEqualToString:@"box"]) {
        _service = [[CRBox alloc] initWithClientId:@"[Box Client Identifier]"
                                      clientSecret:@"[Box Client Secret]"
                                       redirectUri:@"https://www.cloudrailauth.com/auth"
                                             state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Dropbox"]) {
        _service = [[CRDropbox alloc] initWithClientId:@"[Dropbox Client Identifier]"
                                          clientSecret:@"[Dropbox Client Secret]"
                                           redirectUri:@"https://auth.cloudrail.com/com.cloudrail.UnifiedCloudStorage"
                                                 state:@"someState"
                    ];
        [((CRDropbox *)_service) useAdvancedAuthentication];
    } else if ([_serviceName isEqualToString:@"Egnyte"]) {
                _service = [[CREgnyte alloc] initWithDomain:@"[Your Egnyte Domain]"
                                                   clientId:@"[Your Egnyte API Key]"
                                               clientSecret:@"[Your Egnyte Shared Secret]"
                                                redirectUri:@"https://www.cloudrailauth.com/auth"
                                                      state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"Google Drive"]) {
        _service = [[CRGoogleDrive alloc] initWithClientId:@"[Google Drive Client Identifier]"
                                              clientSecret:@""
                                               redirectUri:@"com.cloudrail.AdvancedAuthentication:/oauth2redirect"
                                                     state:@"someState"
                    ];
        [((CRGoogleDrive *)_service) useAdvancedAuthentication];
    } else if ([_serviceName isEqualToString:@"OneDrive"]) {
        _service = [[CROneDrive alloc] initWithClientId:@"[OneDrive Client Identifier]"
                                           clientSecret:@"[OneDrive Client Secret]"
                                            redirectUri:@"https://www.cloudrailauth.com/auth"
                                                  state:@"someState"
                    ];
    } else if ([_serviceName isEqualToString:@"OneDrive for Business"]) {
        _service = [[CROneDriveBusiness alloc] initWithClientId:@"[OneDrive Business Client Identifier]"
                                                   clientSecret:@"[OneDrive Business Client Secret]"
                                                    redirectUri:@"https://www.cloudrailauth.com/auth"
                                                          state:@"someState"
                    ];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedCloudStorage", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        NSUserDefaults* settings = [NSUserDefaults standardUserDefaults];
        NSString* credential = [settings stringForKey:_serviceName];
        if (credential == nil) {
            NSLog(@"logging in");
            [_service login];
            credential = [_service saveAsString];
            [settings setObject:credential forKey:_serviceName];
        } else {
            NSLog(@"using credentials");
            [_service loadAsString:credential];
        }

        [self getFiles];
    });
}

- (void)getFiles {
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedCloudStorage", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        _files = [_service childrenOfFolderWithPath:_currentPath];
        NSLog(@"_currentPath = %@\n", _currentPath);
        
        NSArray *sortedArray;
        sortedArray = [_files sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [(CRCloudMetaData*)a name];
            NSString *second = [(CRCloudMetaData*)b name];
            return [first compare:second];
        }];
        
        _files = [NSMutableArray arrayWithArray:sortedArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //code to be executed by the UI thread
            [self.tableView reloadData];
        });
    });
    [self.tableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_files[indexPath.row] name];
    
    if ([[_files[indexPath.row] folder] isEqualToNumber:[NSNumber numberWithInt:0]]) {
        UIImage* image = [UIImage imageNamed:@"file.png"];
        cell.imageView.image = image;
    } else {
        UIImage* image = [UIImage imageNamed:@"folder.png"];
        cell.imageView.image = image;
    }
    
    return cell;
}

- (void)downloadFile:(NSString*)fileName {
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedCloudStorage", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        NSString *pathToFile = _currentPath;
        if (![pathToFile isEqualToString:@"/"]) {
            pathToFile = [pathToFile stringByAppendingString:@"/"];
        }
        pathToFile = [pathToFile stringByAppendingString:fileName];
        
        NSInputStream* stream = [_service downloadFileWithPath:pathToFile];
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
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
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


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"folderClicked"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        CRCloudMetaData *meta = _files[indexPath.row];
        if ([[meta folder] isEqualToNumber:[NSNumber numberWithInteger:1]]) {
            return YES;
        } else {
            [self downloadFile:[meta name]];
            return NO;
        }
    }
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"folderClicked"]) {
        ShowFilesTableViewController *destViewController = (ShowFilesTableViewController *)segue.destinationViewController;
        
        NSString* newPath = _currentPath;
        NSString* folderName = [_files[[self.tableView indexPathForSelectedRow].row] name];
        if (![newPath isEqualToString:@"/"]) {
            newPath = [newPath stringByAppendingString:@"/"];
        }
        newPath = [newPath stringByAppendingString:folderName];
        destViewController.serviceName = _serviceName;
        destViewController.service = _service;
        destViewController.currentPath = newPath;
    }
}


@end
