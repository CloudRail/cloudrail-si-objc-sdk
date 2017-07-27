//
//  POIWrapper.m
//  UnifiedPOI
//
//  Created by CloudRail on 25.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "POIWrapper.h"

@implementation POIWrapper
- (NSComparisonResult)compare:(POIWrapper *)otherObject {
    return [self.distance compare:otherObject.distance];
}
@end
