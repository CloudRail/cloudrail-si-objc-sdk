//
//  PaymentViewController.m
//  CloudRail_ServiceCode
//
//  Created by Felipe Cesar on 23/06/16.
//  Copyright © 2016 CloudRail. All rights reserved.
//

#import "PaymentViewController.h"

@implementation PaymentViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary * authDic = @{
                               @"paypalKey" : @"AVeum9__j-L3R4d5kCxB6WBHwU6_D2t572vIcsXt5NVJGCfckrFaZUiAQSU9iX2RzS9I6YN8PhWFUzJ7",
                               @"paypalSecret" : @"EACwCe3Rmq7NgSWu0HNOXvxsC_q-SW4NRDUkOsE0vPRCVYZxE2V7bUqJA32j7Da_sW_XJXJOUgtUO2nf",
                             
                               @"stripeKey" : @"sk_test_44hDJ8L9grqg5RJ8WCS5rUUV",
                               };
  
    NSString * key = [[self.serviceName lowercaseString] stringByAppendingString:@"Key"];
    NSString * secret = [[self.serviceName lowercaseString] stringByAppendingString:@"Secret"];
  
    if ([self.serviceName isEqualToString:@"PayPal"]) {
        self.service = [[CRPayPal alloc] initWithUseSandbox:YES clientId:authDic[key] clientSecret:authDic[secret]];
        self.creditCard = [self paypalCard];
    } else if([self.serviceName isEqualToString:@"Stripe"]){
        self.service = [[CRStripe alloc]initWithSecretKey:authDic[key]];
        self.creditCard = [self stripeCard];
    }
}

#pragma mark - Setup Credit/Debit Card Samples

- (CRCreditCard *)paypalCard {
    CRCreditCard * card = [[CRCreditCard alloc] init];
    card.number = @"4032033787054753";
    card.expire_month = @06;
    card.expire_year = @2021;
    card.firstName = @"Patrick";
    card.lastName = @"Stoklasa";
    card.type = @"visa";
    
    card.address = [self customerAddress];
    return card;
}

- (CRCreditCard *)stripeCard {
    CRCreditCard * card = [[CRCreditCard alloc] init];
    card.number = @"4242424242424242";
    card.expire_month = @12;
    card.expire_year = @2017;
    card.cvc = @"123";
    card.firstName = @"Bob";
    card.lastName = @"Bauer";
    card.type = @"visa";
    card.address = [self customerAddress];
    return card;
}

#pragma mark - Customer Address

- (CRAddress *)customerAddress {
    CRAddress *address = [[CRAddress alloc] init];
    address.country = @"US";
    address.city = @"New York";
    address.state = @"NY";
    address.line1 = @"Broadway, 7th Avenue, 42nd and 47th Streets";
    address.line2 = @"Manhattan";
    address.postalCode = @"1003";
    return address;
}

#pragma mark - List of Payment Services

- (IBAction)listSubscriptionPlans:(id)sender {
    NSMutableArray<CRSubscriptionPlan*> * plans = [self.service listSubscriptionPlans];
    NSLog(@"Plans - %@", plans);
}

- (IBAction)cancelSubscription:(id)sender {
  if ([self.serviceName isEqualToString:@"Stripe"]) {
    [self.service cancelSubscriptionWithIdentifier:@"sub_8h0XCMFVcgIule"];
    return;
  }
  
  [self.service cancelSubscriptionWithIdentifier:@"I-X1YC5M5RVVGM"];
}

- (IBAction)createSubscription:(id)sender {
  
  if ([self.serviceName isEqualToString:@"Stripe"]) {
    CRSubscription * subscribed = [self.service createSubscriptionWithPlanID:@"Felipe Awesome" name:@"Bob Client" description:@"Bob subscribed" source:self.creditCard];
    NSLog(@"Subscription - %@", subscribed);
    return;
  }
  
  CRSubscription * subscribed=  [self.service createSubscriptionWithPlanID:@"P-83J31140HE0634304QGWFOUA" name:@"Bob Client" description:@"Bob subscribed" source:self.creditCard];
  
  NSLog(@"Subscription - %@", subscribed);
  
}

- (IBAction)partiallyRefound:(id)sender {
  
  if ([self.serviceName isEqualToString:@"Stripe"]) {
    CRRefund* refund = [self.service partiallyRefundChargeWithIdentifier:@"ch_18PdLMF5KQWFtvy8X571vBlx" amount:@100];
    NSLog(@"Refund - %@", refund);
    return;
  }
  
  CRRefund* refund = [self.service partiallyRefundChargeWithIdentifier:@"PAY-54B164195A4923009K5VDLII" amount:@400];
  NSLog(@"Refund - %@", refund);
}

- (IBAction)createCharge:(id)sender {
    
    if ([self.serviceName isEqualToString:@"Stripe"]) {
        CRCharge * charge = [self.service createChargeWithAmount:@500 currency:@"USD" source:self.creditCard];
        NSLog(@"Charge - %@", charge);
        return;
    }
    
    CRCharge * charge = [self.service createChargeWithAmount:@500 currency:@"USD" source:self.creditCard];
    NSLog(@"Charge - %@", charge);
}

- (IBAction)listCharges:(id)sender {
    
    if ([self.serviceName isEqualToString:@"Stripe"]) {
        NSMutableArray<CRCharge*> * charges = [self.service listChargesFrom:@1466553600 to:@1466719200 creditCard:self.creditCard];
        NSLog(@"Charges - %@", charges);
        return;
    }
    
    NSMutableArray<CRCharge*> * charges = [self.service listChargesFrom:@1466553600000 to:@1466861880000 creditCard:self.creditCard];
    NSLog(@"Charges - %@", charges);
}

- (IBAction)createSubscriptionPlan:(id)sender {
  
    if ([self.serviceName isEqualToString:@"Stripe"]) {
        CRSubscriptionPlan * subPlan = [self.service createSubscriptionPlanWithName:@"Felipe Awesome3" amount:@2000 currency:@"USD" description:@"Avengers bill" interval:@"day" intervalCount:@7];
        NSLog(@"Sub plan %@", subPlan);
        return;
    }
  
    CRSubscriptionPlan * subPlan = [self.service createSubscriptionPlanWithName:@"Felipe Awesome2" amount:@2000 currency:@"USD" description:@"Avengers bill" interval:@"day" intervalCount:@7];
    NSLog(@"Sub plan %@", subPlan);
}

- (IBAction)refoundsForCharge:(id)sender {
    if ([self.serviceName isEqualToString:@"Stripe"]) {
        NSMutableArray<CRRefund*> * refund = [self.service refundsForChargeWithIdentifier:@"ch_18Pcl5F5KQWFtvy8LhOxBzMo"];
        NSLog(@"rfounds - %@", refund);
        return;
    }
    
    NSMutableArray<CRRefund*> * refund = [self.service refundsForChargeWithIdentifier:@"PAY-8DX81751SL278112JK5WRGAQ"];
    NSLog(@"rfounds - %@", refund);
}

- (IBAction)getCharge:(id)sender {
    if ([self.serviceName isEqualToString:@"Stripe"]) {
        CRCharge* charge = [self.service chargeWithIdentifier:@"ch_18PcW7F5KQWFtvy8ffNbOeSs"];
        NSLog(@"charge - %@",charge);
        return;
    }
    
    CRCharge* charge = [self.service chargeWithIdentifier:@"PAY-8DX81751SL278112JK5WRGAQ"];
    NSLog(@"charge - %@",charge);
    return;
}

- (IBAction)getRefound:(id)sender {
    if ([self.serviceName isEqualToString:@"Stripe"]) {
        CRRefund * refund = [self.service refundWithIdentifier:@"re_18Pd0zF5KQWFtvy8woazzTiY"];
        NSLog(@"Refund - %@", refund);
        return;
    }
    
    CRRefund * refund = [self.service refundWithIdentifier:@"36C47073MA8530026"];
    NSLog(@"Refund - %@", refund);
}

- (IBAction)refundCharges:(id)sender {
  
    if ([self.serviceName isEqualToString:@"Stripe"]) {
        CRRefund * refund = [self.service refundChargeWithIdentifier:@"ch_18Pcl5F5KQWFtvy8LhOxBzMo"];
        NSLog(@"Refund - %@", refund);
        return;
    }
    
    CRRefund * refund= [self.service refundChargeWithIdentifier:@"PAY-8DX81751SL278112JK5WRGAQ"];
    NSLog(@"Refund - %@", refund);
}

@end
