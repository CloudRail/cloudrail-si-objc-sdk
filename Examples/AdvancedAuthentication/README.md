# Advanced Authentication Example

This is a small application that demonstrates the CloudRail Advanced Authentication feature using Google Drive. More information on Advanced Authentication can be found on our [Tutorial about Advanced Authentication](https://blog.cloudrail.com/solving-disallowed_useragent-for-google-services/).

## Prerequisites

You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for Google Drive. Instructions on how they can be acquired can be found on our [Unified Cloud Storage API site](https://cloudrail.com/integrations/interfaces/CloudStorage;serviceIds=GoogleDrive). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *TableViewController.m* file and enter your Google Drive Client ID:

```objectivec
_googleDrive = [[CRGoogleDrive alloc] initWithClientId:@"[Google Drive Client ID]"
                                          clientSecret:@""
                                           redirectUri:@"com.cloudrail.AdvancedAuthentication:/oauth2redirect"
                                                 state:@"someState"
                    ];
```

## Using the app

When opening the app, it will log you in using an external browser and then simply display your Google Drive root folder.