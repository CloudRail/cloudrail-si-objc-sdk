# Unified Social Interaction Example

This demo application let's you send status updates to Facebook, Facebook Pages and Twitter.
It is written for iOS in Objective C and uses the [CloudRail Unified Social Interaction API](https://cloudrail.com/integrations/interfaces/Social). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites


You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified Social Interaction API site](https://cloudrail.com/integrations/interfaces/Social). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *PostUpdatesViewController.m* file and enter your developer credentials:

```objectivec
if ([_serviceName isEqualToString:@"Facebook"]) {
    _service = [[CRFacebook alloc] initWithClientId:@"[Facebook Client Identifier]"
                                       clientSecret:@"[Facebook Client Secret]"
                                        redirectUri:@"https://www.cloudrailauth.com/auth"
                                              state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"FacebookPages"]) {
    _service = [[CRFacebookPage alloc] initWithPageName:@"[Facebook Page Identifier]"
                                               clientId:@"[Facebook Client Identifier]"
                                           clientSecret:@"[Facebook Client Secret]"
                                            redirectUri:@"https://www.cloudrailauth.com/auth"
                                                  state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Twitter"]) {
    _service = [[CRTwitter alloc] initWithClientId:@"[Twitter Client Identifier]"
                                      clientSecret:@"[Twitter Client Secret]"
                                       redirectUri:@"https://www.cloudrailauth.com/auth"
                ];
}
```

## Using the app

After choosing a service, enter a message and click on the "Post Update" button. The app will then post the update to the chosen social network service.

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_social_profile.png)