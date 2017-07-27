# Unified Bucket Cloud Storage Example

This demo application let's you view and download files from all of your bucket cloud storage accounts (Amazon Web Services S3, Backblaze, Google Cloud Platform, Microsoft Azure, Rackspace) in a single place.
It is written for iOS in Objective C and uses the [CloudRail Unified Bucket Cloud Storage API](https://cloudrail.com/integrations/interfaces/BusinessCloudStorage;platformId=ObjectiveC). Want to build something similar? [Get started with CloudRail](https://cloudrail.com/signup) today, it's free.

## Prerequisites

You need to have Apple Xcode installed (get it on the [Apple Developer website](https://developer.apple.com/xcode/) or in the [Apple App Store](https://itunes.apple.com/de/app/xcode/id497799835?mt=12)) and need developer credentials for the services you want to use. Instructions on how they can be acquired can be found on our [Unified Cloud Storage API site](https://cloudrail.com/integrations/interfaces/CloudStorage;serviceIds=Box%2CDropbox%2CEgnyte%2CGoogleDrive%2COneDrive%2COneDriveBusiness). You also need a CloudRail API key that you can [get for free here](https://cloudrail.com/signup).

Open your *AppDelegate.m* file and enter your CloudRail Key into the following line of code:

```objectivec
[CRCloudRail setAppKey:@"[Your CloudRail Key]"];
```

Find the following piece of code in your *ShowBucketsTableViewController.m* file and enter your developer credentials:

```objectivec
if ([_serviceName isEqualToString:@"Amazon Web Services S3"]) {
    _service = [[CRAmazonS3 alloc] initWithAccessKeyId:@"[Your S3 Access Key ID]"
                                       secretAccessKey:@"[Your S3 Secret Access Key]"
                                                region:@"[Your AWS region]"
                ];
} else if ([_serviceName isEqualToString:@"Backblaze"]) {
    _service = [[CRBackblaze alloc] initWithAccountID:@"[Your Backblaze Account ID]"
                                               appKey:@"[Your Backblaze App Key]"
                ];
} else if ([_serviceName isEqualToString:@"Google Cloud Platform"]) {
    _service = [[CRGoogleCloudPlatform alloc] initWithClientEmail:@"[Your Google Client Email]"
                                                       privateKey:@"[Your Google Private Key]"
                                                        projectId:@"[Your Google Project ID]"
                ];
} else if ([_serviceName isEqualToString:@"Microsoft Azure Storage"]) {
    _service = [[CRMicrosoftAzure alloc] initWithAccountName:@"[Your Azure Account Name]"
                                                   accessKey:@"[Your Azure Access Key]"
                ];
} else if ([_serviceName isEqualToString:@"Rackspace"]) {
    _service = [[CRRackspace alloc] initWithUsername:@"[Your Rackspace User Name]"
                                              apiKey:@"[Your Rackspace API Key]"
                                              region:@"[Your Rackspace Region]"
                ];
}
```

## Using the app

When opening the app, the user can choose between the different Bucket Cloud Storage providers. They can then view their buckets and download files by clicking on them.

![screenhot](https://github.com/CloudRail/cloudrail.github.io/raw/master/img/ios_demo_unified_bucket_cloud.png)