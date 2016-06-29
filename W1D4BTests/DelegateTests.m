//
//  DelegateTests.m
//  W1D4B
//
//  Created by steve on 2016-06-29.
//  Copyright © 2016 steve. All rights reserved.
//

/* ==================
   DELEGATE CALLBACKS
   ==================
*/

/*
 * To Setup Delegate CallBack do the following
 * 1. Create a protocol in the delegating object (Reachability in this case)
 * 2. Create a property on the delegating object that will hold any object that implements the protocol, make sure it's nonatomic and weak
        // eg. @property (nonatomic, weak)id<ReachabilityDelegate>delegate;
 * 3. The delegating object must have a method that calls the implementation of the protocol on the object that the delegate propery refers to
 * 4. Create a delegate object
 * 5. Import the delegating object's header
 * 6. Add conformity to the protocol on the interface of the delegate:
        // eg. @interface MyBillionDollarApp : NSObject <ReachabilityDelegate>
 * 7. Implement at least the required methods declared by the protocol, and any optional ones you wish to.
 * 8. Initialize the delegating object from the delegate, and assign the delegate to the delegating objects delegate property
        // eg. - (void)someEvent { 
                    self.reachability = [Reachability new];
                    r.delegate = self;
                }
 */

#import <XCTest/XCTest.h>
#import "Reachability.h"

@interface MyBillionDollarApp : NSObject<ReachabilityDelegate>
@property BOOL becameReachableByWIFI;
@property BOOL becameReachableByCellularData;
@property (nonatomic, strong) Reachability *reachability;
// properties used for testing
@end
@implementation MyBillionDollarApp

- (instancetype)init {
    if (self = [super init]) {
        _reachability = [Reachability new];
        _reachability.delegate = self;
        [_reachability someFakeEvent];
    }
    return self;
}

- (void)didBecomeReachableByWIFI:(Reachability *)reachability {
    self.becameReachableByWIFI = YES;
}
- (void)didBecomeReachableByCellularData:(Reachability *)reachability {
    self.becameReachableByCellularData = YES;
}
@end



@interface DelegateTests : XCTestCase
@end

@implementation DelegateTests

- (void)testClassWhetherWIFIBecameReachable {
    MyBillionDollarApp *sut = [MyBillionDollarApp new];
    BOOL result = sut.becameReachableByWIFI;
    XCTAssertEqual(result, YES);
}

- (void)testClassWhetherCellularDataBecameReachable {
    MyBillionDollarApp *sut = [MyBillionDollarApp new];
    BOOL result = sut.becameReachableByCellularData;
    XCTAssertEqual(result, YES);
}

@end
