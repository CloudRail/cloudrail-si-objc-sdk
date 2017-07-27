# Unified Payment Example

This demo application let's you view, add and refund charges using either PayPal or Stripe.
It is written for iOS in Objective C and uses the [CloudRail Unified Payment API](https://cloudrail.com/integrations/interfaces/Payment). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites

You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified Payment API site](https://cloudrail.com/integrations/interfaces/Payment). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *ChargesTableViewController.m* file and enter your developer credentials:

```objectivec
if ([_serviceName isEqualToString:@"PayPal"]) {
    _service = [[CRPayPal alloc] initWithUseSandbox:true
                                           clientId:@"AWW6zTBEkFz4ridW1QgMIg2-KqpR0Ww04d3nf-rooW97B_c9b09Nt3iynL7GKHB1_7rN39oWMB4Sui0c"
                                       clientSecret:@"EIJQze3Ykgu56ajtf8mq8q0dUNqC9-kRCUPvHqakO0r-UkTdRy91hs_kOaj06ZYLYU-WmkO4n0qqQbUB"
                ];
} else if ([_serviceName isEqualToString:@"Stripe"]) {
    _service = [[CRStripe alloc] initWithSecretKey:@"sk_test_AavUPoLur3i2XwEMZjRYnpmb"];
}
```

## Using the app

After choosing a service, the app shows all charges made within the last year. The user can add more charges. The required inputs are the charge amount in the smallest possible units (for example, cents) and the 3-letter currency code. When clicking on a charge, the app will display more detail and gives the possibility to partially or fully refund the charge.

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_payment.png)