//
//  DelegateTests.m
//  W1D4B
//
//  Created by steve on 2016-06-29.
//  Copyright © 2016 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

@protocol BankProtocol <NSObject>
- (void)getAccount;
- (void)getBalance;
@optional
- (void)showPromotion;
@end

@interface BMO : NSObject<BankProtocol>
@end
@implementation BMO
- (void)getAccount{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)getBalance{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end

@interface OptionalProtocolTests : XCTestCase

@end

@implementation OptionalProtocolTests


- (void)testBMOConformsToProtocol {
    BMO *sut = [BMO new];
    BOOL result = [sut conformsToProtocol:@protocol(BankProtocol)];
    XCTAssertTrue(result);
}

- (void)testBMORespondsToOptionalProtocolMethod {
    BMO *sut = [BMO new];
    BOOL result = [sut respondsToSelector:@selector(showPromotion)];
    XCTAssertFalse(result);
}




@end
