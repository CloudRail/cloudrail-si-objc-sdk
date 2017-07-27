# Unified Points of Interest Example

This demo application searches for pizza places around a given location, using different Points of Interest services (Foursquare, Google Places, Yelp).
It is written for iOS in Objective C and uses the [CloudRail Unified Points of Interest API](https://cloudrail.com/integrations/interfaces/PointsOfInterest;serviceIds=Foursquare%2CGooglePlaces%2CYelp;platformId=ObjectiveC). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites

You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified Points of Interest API site](https://cloudrail.com/integrations/interfaces/PointsOfInterest;serviceIds=Foursquare%2CGooglePlaces%2CYelp;platformId=ObjectiveC). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```
Find the following piece of code in your *PoiListViewController.m* file and enter your developer credentials:

```objectivec
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
```

If you want, you can change the location in the *PoiListViewController.m* file:

```objectivec
_latitude = [NSNumber numberWithDouble:49.4872062];
_longitude = [NSNumber numberWithDouble:8.4636127];
```

## Using the app

Upon selecting a service, the app will display Pizza places around the given location, sorted by distance.

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_POI.png)