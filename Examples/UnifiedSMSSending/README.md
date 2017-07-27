# Unified SMS Sending Example

This demo application let's you send SMSs using three different services that allow you to programmatically send SMSs (Nexmo, Twilio and Twizo).
It is written for iOS in Objective C and uses the [CloudRail Unified SMS Sending API](https://cloudrail.com/integrations/interfaces/SMS;platformId=ObjectiveC). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites


You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified SMS Sending API site](https://cloudrail.com/integrations/interfaces/SMS;platformId=ObjectiveC;serviceIds=Nexmo%2CTwilio%2CTwizo). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *ViewController.m* file and enter your developer credentials:

```objectivec
switch ([sender tag]) {
    case 1:
        _service = [[CRNexmo alloc] initWithClientId:@"[Nexmo API Key]"
                                        clientSecret:@"[Nexmo API Secret]"];
        break;
    case 2:
        _service = [[CRTwilio alloc] initWithAccountSid:@"[Twilio Account SID]"
                                              authToken:@"[Twilio Auth Token]"];
        break;
    case 3:
        _service = [[CRTwizo alloc] initWithKey:@"[Twizo Key]"];
        break;
    default:
        break;
}
```

## Using the app

Fill out the fields and click on the "send" buttons to send a SMS. Please note that the services might require different phone number formats, or might only accept sending numbers that they provide to you. 

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_sms.png)