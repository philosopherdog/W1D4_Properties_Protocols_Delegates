//
//  StrongWeakCopyTests.m
//  W1D4
//
//  Created by steve on 2016-06-28.
//  Copyright © 2016 steve. All rights reserved.
//



#import <XCTest/XCTest.h>

@interface Person2 : NSObject
@property (nonatomic, copy) NSString *name;
@end


@interface WeakCopyTests : XCTestCase
@property (nonatomic, weak) NSMutableArray *jobs;
@end

@implementation WeakCopyTests

/*
 * By default properties of objects are atomic and strong
 * By default primative types (int, float, etc.) retain by default, and atomic has no meaning for non-object types in Objc
 * Atomic has to do with thread safety. You will probably never use atomic, since it is slower and doesn't really protect against thread safety
 * ALWAYS declare all object properties as nonatomic
 * You will almost always use strong (default) or copy for objects.
 * strong/copy properties increase the retain count by 1. This means that the object pointed to by the property will exist at least as long as the object retaining it
 * weak is used mostly when you want to avoid retain cycles, and Apple uses it on view outlets
 * Can someone explain what a retain cycle is?
 * weak doesn't increase the retain count
 * So, you only want to make a property weak if you know something else is retaining it otherwise it will disappear
 * if no object has a strong reference to an entity it will be deallocated
 *
 */

#pragma mark - Weak Properties

- (void)testWeakProperty {
    self.jobs = [[NSMutableArray alloc] init];
    XCTAssertNil(self.jobs);
}


/*
 * Reason to make objects with mutable sub-types copy is that client code can assign a mutable type to an immutable type.
 * Later the client code could mutate the string in question and this would change the pointer which is usually not what you want.
 */

- (void)testPointerOfCopyStringProperty {
    Person2 *p = [Person2 new];
    // make a mutable string
    NSMutableString *name = [@"Hank" mutableCopy];
    // assign it to the immutable property
    p.name = name;
    // mutate the original string
    [name appendString:@" some change to the original string"];
    // the Person objects string also changed!
    XCTAssert([p.name isEqualToString:name]);
}



@end
