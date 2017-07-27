//
//  TableViewController.h
//  UnifiedPOI
//
//  Created by CloudRail on 24.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface TableViewController : UITableViewController

@property (nonatomic,strong) id<CRPointsOfInterestProtocol> service;
@property (nonatomic,strong) NSArray *servicesName;

@end
