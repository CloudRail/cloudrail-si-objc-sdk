//
//  TableViewController.m
//  UnifiedPOI
//
//  Created by CloudRail on 24.07.17.
//  Copyright © 2017 CloudRail. All rights reserved.
//

#import "TableViewController.h"
#import "PoiListViewController.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.servicesName = @[@"FourSquare", @"Google Places", @"Yelp"];
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
    return self.servicesName.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.servicesName[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listSegue" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"listSegue"])
    {
        NSIndexPath *index = (NSIndexPath *)sender;
        NSLog(@"%@", self.servicesName[index.row]);
        
        printf("index.row = %ld\n", (long)index.row);
        switch (index.row) {
            case 0:
                _service = [[CRFoursquare alloc] initWithClientId:@"[Foursquare Client Identifier]"
                                                     clientSecret:@"[Foursquare Client Secret]"
                            ];
                break;
            case 1:
                _service = [[CRGooglePlaces alloc] initWithApiKey:@"[Places API Key]"];
                break;
            case 2:
                _service = [[CRYelp alloc] initWithConsumerKey:@"[Yelp Consumer Key]"
                                                consumerSecret:@"[Yelp Consumer Secret]"
                                                         token:@"[Yelp Token]"
                                                   tokenSecret:@"[Yelp Token Secret]"
                            ];
                break;
            default:
                break;
        }
        
        PoiListViewController *controller = (PoiListViewController *)segue.destinationViewController;
        controller.service = _service;
        
        
    }
}


@end
