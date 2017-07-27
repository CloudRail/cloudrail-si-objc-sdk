//
//  ShowBucketsTableViewController.h
//  UnifiedBucketCloudStorage
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>
#import "ShowFilesTableViewController.h"

@interface ShowBucketsTableViewController : UITableViewController
@property (nonatomic,strong) NSString *serviceName;
@property (nonatomic,strong) id<CRBusinessCloudStorageProtocol> service;
@property (nonatomic,strong) NSMutableArray<CRBucket*>* buckets;
@end
