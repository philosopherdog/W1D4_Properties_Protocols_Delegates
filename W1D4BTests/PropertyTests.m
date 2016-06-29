//
//  PropertiesTests.m
//  W1D4
//
//  Created by steve on 2016-06-28.
//  Copyright © 2016 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// Person1 shows how to hand roll a property

@interface Person1 : NSObject {
    NSString *_name;
}
- (NSString *)name;
- (void)setName:(NSString *)name;
@property (nonatomic) NSString *message;
@end

@implementation Person1
- (NSString *)name {
    return _name;
}
- (void)setName:(NSString *)name {
    _name = name;
}
@end

// Person2 shows the same code using a property

@interface Person2 : NSObject
@property (nonatomic) NSString *name;
@end

@implementation Person2
@end

// Person3 shows overriding setter

@interface Person3 : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *label;
@end

@implementation Person3
// NOTICE the compiler generates the setter for us, and we can override it to react to someone setting name!
- (void)setName:(NSString *)name {
    self.label = name;
    _name = name;
}
@end

// Person4 readonly example

@interface Person4 : NSObject
@property (nonatomic, strong, readonly) NSString *name;
@end

@implementation Person4
- (instancetype)init {
    if (self = [super init]) {
        _name = @"Readonly Frank";
    }
    return self;
}

- (void)fakeEventWithData:(NSString *)data {
    _name = data;
}
@end


// Person5 overriding the getter

@interface Person5 : NSObject
@property (nonatomic, strong, readonly) NSNumber *bankAccount;
@end

@implementation Person5

// I have to explicitly declare the _bankAccount as the backing store of the bankAccount property to override the getter

@synthesize bankAccount = _bankAccount;

- (NSNumber *)bankAccount {
    if (!_bankAccount) {
        _bankAccount = [self fakeNetworkRequest];
        return _bankAccount;
    }
    return _bankAccount;
}

// imagine this is an expensive operation
- (NSNumber *)fakeNetworkRequest {
    return @(arc4random_uniform(1000));
}

@end


/*
 TESTS
 */

@interface PropertyTests : XCTestCase
@end

@implementation PropertyTests

#pragma mark - Person1

- (void)testSetAndGetNameUsingDotSyntax {
    Person1 *sut = [[Person1 alloc] init];
    sut.name = @"George"; // calls setter
    NSString *result = sut.name;
    XCTAssert([result isEqualToString:@"George"]);
}

- (void)testSetAndGetNameUsingSquareBracketSyntax {
    Person1 *sut = [[Person1 alloc] init];
    [sut setName:@"Harry"]; // calls setter
    NSString *result = [sut name]; // calls getter
    XCTAssert([result isEqualToString:@"Harry"]);
}

//- (void)cantAccessIvar {
//    Person *sut = [[Person alloc] init];
//    NSString *result = [sut _name];
//}

#pragma mark - Person2

/*
 @property spares us writing all of the setters and getters by hand!
 */

- (void)testSetAndGetNameUsingDotSyntax2 {
    Person2 *sut = [[Person2 alloc] init];
    sut.name = @"Fred"; // calls setter
    NSString *result = sut.name;
    XCTAssert([result isEqualToString:@"Fred"]);
}

- (void)testSetAndGetNameUsingSquareBracketSyntax2 {
    Person2 *sut = [[Person2 alloc] init];
    [sut setName:@"James"]; // calls setter
    NSString *result = [sut name]; // calls getter
    XCTAssert([result isEqualToString:@"James"]);
}

#pragma mark - Person3

/*
 * What's the point of having setters and getters?
 * They encapsulate our data.
 * What does this mean?
 * It means that the class controls access to its data, both setting it and getting it
 * It means the class can prevent objects from setting its data, do validation checks on that data
 * Most importantly it means that the class instance can react to code touching its setter and getter.
 * Why would a class instance want to react to its data being set or retrieved?
 */

- (void)testOverridingSetter {
    Person3 *sut = [[Person3 alloc] init];
    sut.name = @"Adam"; // calls setter
    NSString *result = sut.name;
    XCTAssert([result isEqualToString:@"Adam"]);
    // Notice: name was intercepted and that's where label is set
    NSString *label = sut.label;
    XCTAssert([label isEqualToString:@"Adam"]);
}

#pragma mark - Person4

/*
 * Marking a property as Readonly prevents setting the backing store using the setter both from the outside and inside the class
 * However, you can set properties marked readonly by talking directly to the backing store using underscore _nameOfBackingStore
 
 */

- (void)testReadOnlyPropertyNotSettable {
    Person4 *sut = [[Person4 alloc] init];
    // 2 ways to calling the setter, but the compiler knows they're READONLY
//    sut.name = @"Jo"
//    [sut setName:@"Jen"];
    BOOL result = [sut respondsToSelector:@selector(setName:)];
    XCTAssertEqual(result, NO);
}

- (void)testReadOnlyPropertySettableUsingIvarPrivately {
    Person4 *sut = [[Person4 alloc] init];
    NSString *inputData = @"Hey I set a readonly property";
    [sut fakeEventWithData:inputData];
    NSString *result = sut.name;
    XCTAssertEqual(result, inputData);
}

#pragma mark - Person5

/*
 * An example of overriding a getter is if it's readonly and does something expensive, like a network request where the data in question doesn't change much.
 * Notice we have to explicitly @synthesize the backing store.
 * Question: If we change the condition inside bankAccount to !self.bankAccount we get a crash. Why?
 */

- (void)testOverrideGetterOnReadonlyProperty {
    Person5 *sut = [[Person5 alloc] init];
    NSNumber *result = sut.bankAccount;
    XCTAssertNotNil(result);
}







@end
