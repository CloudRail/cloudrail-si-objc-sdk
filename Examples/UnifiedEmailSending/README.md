# Unified Email Sending Example

This demo application let's you send Emails using two different services that allow you to programmatically send Emails (MailJet and SendGrid).
It is written for iOS in Objective C and uses the [CloudRail Unified Email Sending API](https://cloudrail.com/integrations/interfaces/Email;platformId=ObjectiveC). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites


You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified Email Sending API site](https://cloudrail.com/integrations/interfaces/Email). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *ViewController.m* file and enter your developer credentials:

```objectivec
- (IBAction)mailjetButtonClicked:(id)sender {
    _service = [[CRMailJet alloc] initWithClientId:@"[Mailjet API Key]"
                                      clientSecret:@"[Mailjet API Private Key]"
                ];
    [self sendMail];
}

- (IBAction)sendGridButtonClicked:(id)sender {
    _service = [[CRSendGrid alloc] initWithApiKey:@"[SendGrid API Key]"
                ];
    [self sendMail];
}
```

## Using the app

Fill out the fields and click on the "send" buttons to send Emails. You might need to first verify addresses with the services before you can use them as sender. 

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_email.png)