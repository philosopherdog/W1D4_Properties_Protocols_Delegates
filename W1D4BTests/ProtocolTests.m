//
//  DelegationTest.m
//  W1D4B
//
//  Created by steve on 2016-06-28.
//  Copyright © 2016 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// Using protocols for
@interface User : NSObject
@property (nonatomic, strong) NSString *name;
@end
@implementation User
@end

@protocol PaymentGateWay <NSObject>
- (void)pay:(User *)user;
@end

@interface Stripe: NSObject<PaymentGateWay>
@end
@implementation Stripe
- (void)pay:(User *)user {
    NSLog(@"%@ made a payment with Stripe", user.name);
}
@end

@interface PayPal : NSObject<PaymentGateWay>
@end
@implementation PayPal
- (void)pay:(User *)user {
    NSLog(@"===>>> %@ made a payment with Paypal", user.name);
}
@end

@interface ShoppingCart : NSObject
- (void)makePurchaseWithGateWay:(id<PaymentGateWay>)gateWay forUser:(User *)user;
@end
@implementation ShoppingCart
- (void)makePurchaseWithGateWay:(id<PaymentGateWay>)gateWay forUser:(User *)user {
    [gateWay pay:user];
}
@end

@interface ProtocolTests : XCTestCase
@end

@implementation ProtocolTests
- (void)testProtocol {
    ShoppingCart *cart = [[ShoppingCart alloc] init];
    PayPal *pp = [[PayPal alloc] init];
    User *user = [User new];
    user.name = @"Fred";
    [cart makePurchaseWithGateWay:pp forUser:user];
}


@end
