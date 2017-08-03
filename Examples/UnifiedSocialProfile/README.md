# Unified Social Profile Example

This demo application let's you view profile informatin from several different social network and social login services (Facebook, GitHub, Google+, Heroku, Instagram, LinkedIn, Product Hunt, Slack, Twitter, Windows Live, Yahoo!).
It is written for iOS in Objective C and uses the [CloudRail Unified Social Profile API](https://cloudrail.com/integrations/interfaces/Profile). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites


You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified Social Profile API site](https://cloudrail.com/integrations/interfaces/Profile). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *ViewController.m* file and enter your developer credentials:

```objectivec
if ([_serviceName isEqualToString:@"Facebook"]) {
    _service = [[CRFacebook alloc] initWithClientId:@"[Facebook Client Identifier]"
                                       clientSecret:@"[Facebook Client Secret]"
                                        redirectUri:@"https://www.cloudrailauth.com/auth"
                                              state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"GitHub"]) {
    _service = [[CRGitHub alloc] initWithClientId:@"[GitHub Client Identifier]"
                                     clientSecret:@"[GitHub Client Secret]"
                                      redirectUri:@"https://www.cloudrailauth.com/auth"
                                            state:@"someState"
                 ];
} else if ([_serviceName isEqualToString:@"Google+"]) {
    _service = [[CRGooglePlus alloc] initWithClientId:@"[Google Plus Client Identifier]"
                                         clientSecret:@"[Google Plus Client Secret]"
                                          redirectUri:@"https://www.cloudrailauth.com/auth"
                                                state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Heroku"]) {
    _service = [[CRHeroku alloc] initWithClientId:@"[Heroku Client Identifier]"
                                     clientSecret:@"[Heroku Client Secret]"
                                      redirectUri:@"https://www.cloudrailauth.com/auth"
                                            state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Instagram"]) {
    _service = [[CRInstagram alloc] initWithClientId:@"[Instagram Client Identifier]"
                                        clientSecret:@"[Instagram Client Secret]"
                                         redirectUri:@"https://www.cloudrailauth.com/auth"
                                               state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"LinkedIn"]) {
    _service = [[CRLinkedIn alloc] initWithClientId:@"[LinkedIn Client Identifier]"
                                       clientSecret:@"[LinkedIn Client Secret]"
                                        redirectUri:@"https://www.cloudrailauth.com/auth"
                                              state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Product Hung"]) {
    _service = [[CRProductHunt alloc] initWithClientId:@"[Product Hunt Client Identifier]"
                                          clientSecret:@"[Product Hunt Client Secret]"
                                           redirectUri:@"https://www.cloudrailauth.com/auth"
                                                 state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Slack"]) {
    _service = [[CRSlack alloc] initWithClientId:@"[Slack Client Identifier]"
                                    clientSecret:@"[Slack Client Secret]"
                                     redirectUri:@"https://www.cloudrailauth.com/auth"
                                           state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Twitter"]) {
    _service = [[CRTwitter alloc] initWithClientId:@"[Twitter Client Identifier]"
                                      clientSecret:@"[Twitter Client Secret]"
                                       redirectUri:@"https://www.cloudrailauth.com/auth"
                ];
} else if ([_serviceName isEqualToString:@"Windows Live"]) {
    _service = [[CRMicrosoftLive alloc] initWithClientId:@"[Windows Live Client Identifier]"
                                            clientSecret:@"[Windows Live Client Secret]"
                                             redirectUri:@"https://www.cloudrailauth.com/auth"
                                                   state:@"someState"
                ];
} else if ([_serviceName isEqualToString:@"Yahoo!"]) {
    _service = [[CRYahoo alloc] initWithClientId:@"[Yahoo Client Identifier]"
                                    clientSecret:@"[Yahoo Client Secret]"
                                     redirectUri:@"https://www.cloudrailauth.com/auth"
                                           state:@"someState"
                ];
}
```

## Using the app

After choosing a service, the app will display - depending on which of them are made available by the service - the profile picture, name, email, birthday and unique identifier. The unique identifier can be used to build services using social login.

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_social_profile.png)