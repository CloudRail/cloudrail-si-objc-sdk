//
//  ShowFilesTableViewController.h
//  UnifiedCloudStorage
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface ShowFilesTableViewController : UITableViewController
@property (nonatomic,strong) NSString* serviceName;
@property (nonatomic,strong) id<CRCloudStorageProtocol> service;
@property (nonatomic,strong) NSString* currentPath;
@property (nonatomic,strong) NSMutableArray<CRCloudMetaData*>* files;
@end
