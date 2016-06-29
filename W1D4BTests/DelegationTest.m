//
//  DelegationTest.m
//  W1D4B
//
//  Created by steve on 2016-06-28.
//  Copyright © 2016 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// Using protocols for callbacks/delegation

@protocol HappinessDelegate <NSObject>
- (void)happinessLevel:(NSInteger)level;
@end

@interface Baby : NSObject
@property (nonatomic, weak) id <HappinessDelegate> delegate;
- (void)askBabyForHappinessLevel;
@end

@implementation Baby
- (void)askBabyForHappinessLevel {
    NSInteger valueGotFromSomewhere = 10;
    [self.delegate happinessLevel:valueGotFromSomewhere];
}
@end

@interface Parent : NSObject<HappinessDelegate>
@property NSInteger level;
@end

@implementation Parent
- (void)happinessLevel:(NSInteger)level {
    NSLog(@"the baby says s/he is %@ level of happiness", @(level));
    self.level = level;
}

@end

@interface DelegationTest : XCTestCase

@end

@implementation DelegationTest


- (void)testDelegation {
    Baby *b = [Baby new];
    Parent *p = [Parent new];
    b.delegate = p;
    [b askBabyForHappinessLevel];
    XCTAssertEqual(p.level, 10);
}



@end
