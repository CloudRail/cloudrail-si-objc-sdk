//
//  PoiListViewController.m
//  UnifiedPOI
//
//  Created by CloudRail on 24.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "PoiListViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PoiListViewController ()

@end

@implementation PoiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray *categories = nil;
    
    dispatch_queue_t queue = dispatch_queue_create("com.cloudrail.UnifiedPOI", NULL);
    _latitude = [NSNumber numberWithDouble:49.4872062];
    _longitude = [NSNumber numberWithDouble:8.4636127];
    dispatch_async(queue, ^{
        //code to be executed in the background
        NSMutableArray<CRPOI *> *pois = [_service nearbyPoisWithLatitude:_latitude
                                                            longitude:_longitude
                                                               radius:[NSNumber numberWithInt:1000]
                                                           searchTerm:@"pizza"
                                                           categories:categories
                                      ];
        
        NSMutableArray *unsortedPois = [[NSMutableArray alloc] init];
        for(CRPOI * poi in pois) {
            
            double poiLat = [poi.location.latitude doubleValue];
            double poiLng = [poi.location.longitude doubleValue];
            
            CLLocation * location1 = [[CLLocation alloc]initWithLatitude:[_latitude doubleValue] longitude:[_longitude doubleValue]];
            CLLocation * location2 = [[CLLocation alloc]initWithLatitude: poiLat longitude:poiLng];
            
            POIWrapper * poiWrapper = [[POIWrapper alloc] init];
            poiWrapper.distance = [NSNumber numberWithInt:(int)[location1 distanceFromLocation:location2]];
            poiWrapper.poi = poi;
            [unsortedPois addObject:poiWrapper];
        }
        
        _pois = [unsortedPois sortedArrayUsingSelector:@selector(compare:)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //code to be executed on the main thread when background task is finished
            [self.tableView reloadData];
        });
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_pois count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _pois[indexPath.row].poi.name;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i meter", [_pois[indexPath.row].distance intValue]];
    
    return cell;
}

@end
