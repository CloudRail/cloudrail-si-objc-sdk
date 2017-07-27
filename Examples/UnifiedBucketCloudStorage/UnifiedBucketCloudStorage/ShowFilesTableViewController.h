//
//  ShowFilesTableViewController.h
//  UnifiedBucketCloudStorage
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface ShowFilesTableViewController : UITableViewController
@property (nonatomic,strong) id<CRBusinessCloudStorageProtocol> service;
@property (nonatomic,strong) CRBucket* bucket;
@property (nonatomic,strong) NSMutableArray<CRBusinessFileMetaData*>* files;
@end
