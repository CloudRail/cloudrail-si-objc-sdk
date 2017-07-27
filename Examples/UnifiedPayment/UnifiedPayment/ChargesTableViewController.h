//
//  ChargesTableViewController.h
//  UnifiedPayment
//
//  Created by CloudRail on 26.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>
#import "ChargeDetailViewController.h"

@interface ChargesTableViewController : UITableViewController
@property (nonatomic,strong) NSString *serviceName;
@property (nonatomic,strong) id<CRPaymentProtocol> service;
@property (nonatomic,strong) NSMutableArray<CRCharge *> *charges;
@end
