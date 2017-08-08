//
//  TableViewController.h
//  AdvancedAuthentication
//
//  Created by CloudRail on 03.08.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <CloudrailSI/CloudrailSI.h>
#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController
@property (nonatomic,strong) CRGoogleDrive *googleDrive;
@property (nonatomic,strong) NSMutableArray<CRCloudMetaData *> *files;
@end
