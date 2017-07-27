//
//  POIWrapper.h
//  UnifiedPOI
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CloudrailSI/CloudrailSI.h>

@interface POIWrapper : NSObject
@property CRPOI * poi;
@property NSNumber * distance;
- (NSComparisonResult)compare:(POIWrapper *)otherObject;
@end
