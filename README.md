<p align="center">
<img width="200px" src="http://cloudrail.github.io/img/cloudrail_logo_github.png"/>
</p>

# CloudRail SI for iOS

Integrate Multiple Services With Just One API

<p align="center">
<img width="300px" src="http://cloudrail.github.io/img/cloudrail_si_github.png"/>
</p>

CloudRail is an API integration solution which abstracts multiple APIs from different providers into a single and universal interface.

**Current Interfaces:**
<p align="center">
<img width="800px" src="http://cloudrail.github.io/img/available_interfaces_v3.png"/>
</p>
---

[![CocoaPods](https://img.shields.io/cocoapods/v/cloudrail-si-ios-sdk.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/cloudrail-si-ios-sdk.svg)]()
<!--[![CocoaPods](https://img.shields.io/cocoapods/l/cloudrail-si-ios-sdk.svg?maxAge=2592000)]()-->
<!--[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/cloudrail-si-ios-sdk.svg?maxAge=2592000)]()-->
<!--[![CocoaPods](https://img.shields.io/cocoapods/aw/cloudrail-si-ios-sdk.svg?maxAge=2592000)]()-->
<!--[![CocoaPods](https://img.shields.io/cocoapods/at/cloudrail-si-ios-sdk.svg?maxAge=2592000)]()-->
<!--asdas-->
<!--[![CocoaPods](https://img.shields.io/cocoapods/dw/cloudrail-si-ios-sdk.svg?maxAge=2592000)]()-->
<!--[![CocoaPods](https://img.shields.io/cocoapods/dm/cloudrail-si-ios-sdk.svg?maxAge=2592000)]()-->
<!--[![CocoaPods](https://img.shields.io/cocoapods/dt/cloudrail-si-ios-sdk.svg?maxAge=2592000)]()-->

Full documentation can be found at our [website](https://cloudrail.com/integrations).

Learn more about CloudRail on https://cloudrail.com

---
---

With CloudRail, you can easily integrate external APIs into your application. 
CloudRail provides abstracted interfaces that take several services and then exposes a developer-friendly API that uses common functions between all providers. 
This means that, for example, upload() works in exactly the same way for Dropbox as it does for Google Drive, OneDrive, and other Cloud Storage Services, and getEmail() works similarly the same way across all social networks.

## CocoaPods
Add the pod to your podfile
```
pod 'cloudrail-si-objc-sdk'
```
run
```
pod install
```

## Basic setup
In the Project Navigator, open the source file of your application delegate. Add the import statement at the top of the file, then add the following call to CloudRail in the didFinishLaunching or didFinishLaunchingWithOptions method of your app delegate:
```objective-c
#import <CloudRailSI/CloudRailSI.h>

[CRCloudRail setAppKey:@"{Your_License_Key}"];
```
---

## Current Interfaces:
Interface | Included Services
--- | ---
Cloud Storage | Dropbox, Google Drive, OneDrive, Box, PCloud, Egnyte, OneDrive Business
Business Cloud Storage | Amazon S3, Microsoft Azure, Rackspace, Backblaze
Social Profiles | Facebook, GitHub, Google+, LinkedIn, Slack, Twitter, Windows Live, Yahoo, Instagram, Heroku
Social Interaction | Facebook, Twitter
Payment | PayPal, Stripe
Email | Maljet, Sendgrid, Gmail
SMS | Twilio, Nexmo
Point of Interest | Google Places, Foursquare, Yelp
Video | Youtube, Twitch, Vimeo
Messaging | Facebook Messenger, Telegram, Line, Viber

---
### Cloud Storage Interface:

* Dropbox
* Box
* Google Drive
* Microsoft OneDrive
* PCloud
* Egnyte
* OneDrive Business

#### Features:

* Download files from Cloud Storage.
* Upload files to Cloud Storage.
* Get Meta Data of files, folders and perform all standard operations (copy, move, etc) with them.
* Retrieve user and quota information.
* Generate share links for files and folders.

#### Code Sample

[Full Documentation](https://cloudrail.com/integrations/interfaces/CloudStorage;platformId=ObjectiveC)
```objective-c
id<CRCloudStorageProtocol> service;

//   service = [[CROneDrive alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];
//   service = [[CRGoogleDrive alloc] initWithClientId:@"clientIdentifier" clientSecret:@"" redirectUri:@"REDIRURL" state:@"CRSTATE"];
//   service = [[CRBox alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];
//   service = [[CRPCloud alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];

service = [[CRDropbox alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];
NSInputStream * object = [service downloadFileWithPath:@"/mudkip.jpg"];
//READ FROM STREAM
```

---
### Business/Bucket Cloud Storage Interface:

* Amazon Web Services S3
* Microsoft Azure
* Rackspace
* Backblaze

#### Features

* Create, delete and list buckets
* Upload files
* Download files
* List files in a bucket and delete files
* Get file metadata (last modified, size, etc.)


#### Code Sample
[Full Documentation](https://cloudrail.com/integrations/interfaces/BusinessCloudStorage;platformId=ObjectiveC)

```objective-c
id<CRBusinessCloudStorageProtocol> service;

// service = [[CRMicrosoftAzure alloc] initWithAccountName:@"[account_name]" accessKey:@"[access_key]"];
// service = [[CRAmazonS3 alloc] initWithAccessKeyId:@"[clientID]" secretAccessKey:@"[client_Secret]" region:@"[region]"];
// service = [[CRRackspace alloc] initWithUsername:@"[username]" apiKey:@"[api_key]" region:@"[region]"];

service = [[CRBackblaze alloc] initWithAccountID:@"[account_init]" appKey:@"[app_key]"];

CRBucket * bucket = [[CRBucket alloc] init];
bucket.name = @"[bucket_name]";
bucket.identifier = @"[bucket_id]";

NSData * data = //data source;
NSInputStream * inputStream = [NSInputStream inputStreamWithData:data];
@try {
  [service uploadFileToBucket:bucket name:@"[file_name]" withStream:inputStream size:data.length];
} @catch (NSException *exception) {
  //handle exception
}
```

---
### Social Media Profiles Interface:

* Facebook
* Github
* Google Plus
* LinkedIn
* Slack
* Twitter
* Windows Live
* Yahoo
* Instagram
* Heroku

#### Features

* Get profile information, including full names, emails, genders, date of birth, and locales.
* Retrieve profile pictures.
* Login using the Social Network.

#### Code Sample 
[Full Documentation](https://cloudrail.com/integrations/interfaces/Profile;platformId=ObjectiveC)

```objective-c
id<CRProfileProtocol> service;

//  service = [[CRGitHub alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];
//  service = [[CRInstagram alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];
//  service = [[CRSlack alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];
//  service = [[CRGooglePlus alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];

service = [[CRFacebook alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];

NSString * fullName = [service fullName];
```

---

### Social Media Interaction Interface:

* Facebook
* Twitter

#### Features

* Get a list of connections.
* Make a post for the user.


#### Code Sample 
[Full Documentation](https://cloudrail.com/integrations/interfaces/Social;platformId=ObjectiveC)

```objective-c
id<CRSocialProtocol> service;

// service = [[CRTwitter alloc] initWithClientIdentifier:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL"];

service = [[CRFacebook alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"REDIRURL" state:@"CRSTATE"];
[service postUpdateWithContent:@"Using Cloudrail sdk!"];
```
---

### Payment Interface:

* PayPal
* Stripe

#### Features Interface

* Perform charges
* Refund previously made charges
* Manage subscriptions

#### Code Sample
[Full Documentation](https://cloudrail.com/integrations/interfaces/Payment;platformId=ObjectiveC)

```objective-c
id<CRPaymentProtocol> service;

//  service = [[CRPayPal alloc] initWithUseSandbox:YES clientId:@"key" clientSecret:@"secret"];

service = [[CRStripe alloc] initWithSecretKey:@"key"];

SubscriptionPlan * subPlan = [service createSubscriptionPlanWithName:@"Plan name" amount:@2000 currency:@"USD" description:@"description" Longerval:@"day" Longerval_count:@7];

NSLog(@"Sub plan %@", subPlan);
```
---

### Email Interface:

* Mailjet
* Sendgrid
* Gmail

#### Features

* Send Email

#### Code Sample
[Full Documentation](https://cloudrail.com/integrations/interfaces/Email;platformId=ObjectiveC)

```objective-c
id<CREmailProtocol> service;

//  service = [[CRMailJet alloc] initWithClientId:@"key" clientSecret:@"secret"];
// service = [[CRGMail alloc] initWithClientID:@"[GMail Client Identifier]" clientSecret:@"" redirectUri:@"com.cloudrail.example:/auth" state:@"someState"];
//[service useAdvancedAuthentication]; //required for Gmail

service = [[CRSendGrid alloc]initWithUsername:@"key" password:@"secret"];

CRAttachment *attachImage = [[CRAttachment alloc] initWithContent:NSInputStream type:"image/jpg" name:"fileName"];
NSMutableArray *attachments = [[NSMutableArray alloc] init];
[attachments addObject:attachImage];

[service sendEmailFromAddress:@"cloudrail@cloudrail.com" fromName:@"Bob" toAddresses:[@[@"foo@gmail.com",@"bar@gmail.com"] mutableCopy] subject:@"Mailjet and SendGrid" textBody:@"The Mailjet and Sendgrid is on cloudrail now!!!" htmlBody:@"" ccAddresses:[@[]mutableCopy] bccAddresses:[@[] mutableCopy], attachments:attachments];
```

---

### SMS Interface:

* Twilio
* Nexmo
* Twizo

#### Features

* Send SMS

#### Code Sample
[Full Documentation](https://cloudrail.com/integrations/interfaces/SMS;platformId=ObjectiveC)

```objective-c
id<CRSMSProtocol> service;

//service = [[CRNexmo alloc] initWithClientId:@"key" clientSecret:@"secret"];

service = [[CRTwilio alloc] initWithAccountSid:@"key" authToken:@"secret"];

[service sendSmsFromName:@"from Code" toNumber:@"+12323423423" content:@"Testing message"];
```
---

### Points of Interest Interface:

* Google Places
* Foursquare
* Yelp

#### Features

* Get a list of POIs nearby
* Filter by categories or search term

#### Code Example
[Full Documentation](https://cloudrail.com/integrations/interfaces/PointsOfInterest;platformId=ObjectiveC)

```objective-c
id<CRPointsOfInterestProtocol> service;

//  service = [[CRYelp alloc] initWithConsumerKey:@"key" consumerSecret:@"secret" token:@"token"  tokenSecret:@"tokensecret"];
//  service = [[CRGooglePlaces alloc] initWithApiKey:@"apiKey"];

service = [[CRFoursquare alloc] initWithClientId:key clientSecret:secret];
NSMutableArray<POI*>* pois =  [self.service nearbyPoisWithLatitude:@49.483927 longitude:@8.473272 radius:@300 searchTerm:[NSNull null] categories:[NSNull null]];

NSLog(@"%@", pois);
```
---

### Video Interface:

* Youtube
* Twitch
* Vimeo

#### Features

* Search for videos
* Upload videos
* Get a list of videos for a channel
* Get channel details
* Get your own channel details
* Get video details 

#### Code Example - Objective-C
[Full Documentation](https://cloudrail.com/integrations/interfaces/Video;platformId=ObjectiveC)

```objective-c
id<CRVideoProtocol> service;

//  service = [[CRTwitch alloc] initWithClientId:@"[Twitch Client Identifier]" clientSecret:@"[Twitch Client Secret]"];
//  service = [[CRVimeo alloc] initWithClientId:@"[Vimeo Client Identifier]" clientSecret:@"[Vimeo Client Secret]"];

service = [[CRYouTube alloc] initWithClientId:@"[YouTube Client Identifier]" clientSecret:@"" redirectUri:@"com.cloudrail.example:/auth" state:@"someState"];
[service useAdvancedAuthentication]; //required for Youtube


NSMutableArray<CRVideoMetaData *> * searchResult = [service searchVideosWithQueryQuery:@"CloudRail" offset:[NSNumber numberWithInt: 0] limit:[NSNumber numberWithInt: 12]];

NSLog(@"%@", searchResult);

CRVideoMetaData * uploadResult = [service uploadVideoWithTitleTitle:@"HowTo: Setup CloudRail" 
        description:@"Video about Setting up CloudRail" 
        stream:NSInputStream 
        size:[NSNumber numberWithInt: 1448576] 
        channelId:@"70207321" 
        mimeType:@"video/mp4"
]; //ChannelId optional for youtube

NSLog(@"%@", uploadResult);

```
---
### Messaging Interface:

* FacebookMessenger
* Telegram
* Line
* Viber

#### Features

* Send text messages
* Send files, images, videos and audios
* Parse a message received on your webhook
* Download the content of an attachment sent to your webhook

#### Code Example - Objective-C
[Full Documentation](https://cloudrail.com/integrations/interfaces/Messaging;platformId=ObjectiveC)

```objective-c
id<CRMessagingProtocol> service;

//  service = [[CRViber alloc] initWithBotToken:@"[Bot Token]" webhook:@"[Webhook URL]" botName:@"[Bot Name]"];
//  service = [[CRTelegram alloc] initWithBotToken:@"[Bot Token]" webhook:@"[Webhook URL]"];
//  service = [[CRLine alloc] initWithBotToken:@"[Bot Token]"];

service =  [[CRFacebookMessenger alloc] initWithBotToken:@"[Bot Token]"];

CRMessage * result = [service sendMessageWithReceiverIdReceiverId:@"12123242" 
        message:@"It's so easy to send message via CloudRail"
];

NSLog(@"%@", result);

```

---

More interfaces are coming soon.

## Advantages of Using CloudRail

* Consistent Interfaces: As functions work the same across all services, you can perform tasks between services simply.

* Easy Authentication: CloudRail includes easy ways to authenticate, to remove one of the biggest hassles of coding for external APIs.

* Switch services instantly: One line of code is needed to set up the service you are using. Changing which service is as simple as changing the name to the one you wish to use.

* Simple Documentation: There is no searching around Stack Overflow for the answer. The CloudRail documentation at https://cloudrail.com/integrations is regularly updated, clean, and simple to use.

* No Maintenance Times: The CloudRail Libraries are updated when a provider changes their API.

* Direct Data: Everything happens directly in the Library. No data ever passes a CloudRail server.

## Integrate With Cocoapods

CloudRail-SI-iOS is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile (remember to put the `use_frameworks!` flag on top of the `Podfile`):
```ruby
pod 'cloudrail-si-objc-sdk'
```
Run `Pod install` again.

### Objective-C

* Import the framework on the desired class with `#import <CloudRailSI/CloudRailSI.h>`.

## Integrate Into Projects Without Cocoapods

Simply drag an drop the Framework file to the __"Embedded Binaries"__ of the iOS project, check __"copy files"__ if needed. Import the framework on the desired class with `#import <CloudRailSI/CloudRailSI.h>`, and have fun!

# Start implementing

Now that you are all set up, you can learn how to use CloudRail by heading over to [[Usage]].
## Other Code Samples

```objective-c
#import <CloudRailSI/CloudRailSI.h>

@interface CRViewController ()
@property (strong, nonatomic) CRDropbox * dropbox;
@property (strong, nonatomic) CRGoogleDrive * googleDrive;
//@property (strong, nonatomic) CROneDrive * oneDrive;
//@property (strong, nonatomic) CRBox * box;
@end

@implementation CRViewController

- (void)viewDidLoad {
[super viewDidLoad];
[CRCloudRail setAppKey:@"CLOUDRAIL_API_KEY"];

self.dropbox = [[CRDropbox alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"https://www.cloudrailauth.com/auth" state:@"CRSTATE"];

self.googleDrive = [[CRGoogleDrive alloc] initWithClientId:@"clientIdentifier" clientSecret:@"clientSecret" redirectUri:@"https://www.cloudrailauth.com/auth" state:@"CRSTATE"];
[self.googleDrive useAdvancedAuthentication]; //Required for Google Login

}

- (void)downloadAndUpload {

//Download File from Dropbox
NSInputStream * streamToDownloadedFile = [self.dropbox downloadFileWithPath:@"/mudkip.jpg"];

//Upload the downloaded file to Googledrive
[self.googleDrive uploadFileToPath:@"/mudkip.jpg" withStream:streamToDownloadedFile size:size overwrite:YES];
}

@end
```

## License Key

CloudRail provides a developer portal which offers usage insights for the SDKs and allows you to generate license keys.

It's free to sign up and generate a key.

Head over to https://cloudrail.com/signup

## Pricing

Learn more about our pricing on https://cloudrail.com/pricing 

## Other Platforms

CloudRail is also available for other platforms like Node.js, Java and Android. You can find all libraries on https://cloudrail.com

## Questions?

Get in touch at any time by emailing us: support@cloudrail.com

or

Tag a question with cloudrail on [StackOverflow](http://stackoverflow.com/questions/tagged/cloudrail)
