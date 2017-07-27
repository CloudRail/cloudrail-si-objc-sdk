//
//  ChargeDetailViewController.h
//  UnifiedPayment
//
//  Created by CloudRail on 27.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface ChargeDetailViewController : UIViewController
@property (nonatomic,strong) id<CRPaymentProtocol> service;
@property (nonatomic,strong) CRCharge *charge;
@end
