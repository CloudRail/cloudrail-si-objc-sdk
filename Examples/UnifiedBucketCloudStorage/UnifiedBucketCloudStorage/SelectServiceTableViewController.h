//
//  SelectServiceTableViewController.h
//  UnifiedBucketCloudStorage
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>
#import "ShowBucketsTableViewController.h"

@interface SelectServiceTableViewController : UITableViewController
@property (nonatomic,strong) NSArray<NSString*>* serviceNames;
@end
