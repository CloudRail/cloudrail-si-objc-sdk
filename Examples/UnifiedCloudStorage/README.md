# Unified Cloud Storage Example

This demo application let's you view and download files from all of your cloud storage accounts (box, Dropbox, Egnyte, Google Drive, OneDrive, OneDrive for Business) in a single place.
It is written for iOS in Objective C and uses the [CloudRail Unified Cloud Storage API](https://cloudrail.com/integrations/interfaces/CloudStorage;platformId=ObjectiveC). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites

You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified Cloud Storage API site](https://cloudrail.com/integrations/interfaces/CloudStorage;serviceIds=Box%2CDropbox%2CEgnyte%2CGoogleDrive%2COneDrive%2COneDriveBusiness). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *ShowFilesTableViewController.m* file and enter your developer credentials:

```objectivec
if ([_serviceName isEqualToString:@"box"]) {
    _service = [[CRBox alloc] initWithClientId:@"[Box Client Identifier]"
                                  clientSecret:@"[Box Client Secret]"
                                   redirectUri:@"https://www.cloudrailauth.com/auth"
                                         state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Dropbox"]) {
    _service = [[CRDropbox alloc] initWithClientId:@"[Dropbox Client Identifier]"
                                      clientSecret:@"[Dropbox Client Secret]"
                                       redirectUri:@"https://auth.cloudrail.com/com.cloudrail.UnifiedCloudStorage"
                                             state:@"someState"
                ];
    [((CRDropbox *)_service) useAdvancedAuthentication];            
} else if ([_serviceName isEqualToString:@"Egnyte"]) {
            _service = [[CREgnyte alloc] initWithDomain:@"[Your Egnyte Domain]"
                                               clientId:@"[Your Egnyte API Key]"
                                           clientSecret:@"[Your Egnyte Shared Secret]"
                                            redirectUri:@"https://www.cloudrailauth.com/auth"
                                                  state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Google Drive"]) {
    _service = [[CRGoogleDrive alloc] initWithClientId:@"[Google Drive Client Identifier]"
                                          clientSecret:@""
                                           redirectUri:@"com.cloudrail.AdvancedAuthentication:/oauth2redirect"
                                                 state:@"someState"
                ];
    [((CRGoogleDrive *)_service) useAdvancedAuthentication];
} else if ([_serviceName isEqualToString:@"OneDrive"]) {
    _service = [[CROneDrive alloc] initWithClientId:@"[OneDrive Client Identifier]"
                                       clientSecret:@"[OneDrive Client Secret]"
                                        redirectUri:@"https://www.cloudrailauth.com/auth"
                                              state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"OneDrive for Business"]) {
    _service = [[CROneDriveBusiness alloc] initWithClientId:@"[OneDrive Business Client Identifier]"
                                               clientSecret:@"[OneDrive Business Client Secret]"
                                                redirectUri:@"https://www.cloudrailauth.com/auth"
                                                      state:@"someState"
                ];
}
```


## Using the app

When opening the app, the user can choose between the different Cloud Storage providers. They can then browse their cloud storage and download files by clicking on them.

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_cloud.png)
