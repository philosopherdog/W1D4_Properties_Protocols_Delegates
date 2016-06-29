//
//  ProtocolTests.m
//  W1D4
//
//  Created by steve on 2016-06-28.
//  Copyright © 2016 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

#pragma mark - First Copy Program

@interface Keyboard1 : NSObject
- (NSString *)read;
@end
@implementation Keyboard1
- (NSString *)read {
    return @"==>>> some data";
}
@end

@interface Printer1 : NSObject
- (void)printData:(NSString *)data;
@end
@implementation Printer1
- (void)printData:(NSString *)data {
    NSLog(@"%@", data);
}
@end

@interface CopyProgram1 : NSObject
- (void)copy;
@end
@implementation CopyProgram1
- (void)copy {
    Keyboard1 *kb = [Keyboard1 new];
    NSString *data = [kb read];
    Printer1 *prt = [Printer1 new];
    [prt printData:data];
}
@end

#pragma mark - Second Copy Program

// We need to be able to output to a network printer.

@interface NetworkPrinter: NSObject
- (void)printDataToNetwork:(NSString *)data;
@end

@implementation NetworkPrinter
- (void)printDataToNetwork:(NSString *)data {
    NSLog(@"===>> %s %@", __PRETTY_FUNCTION__, data);
}
@end

@interface CopyProgram2 : NSObject
- (void)copy;
@property BOOL networkPrinterFlag;
@end


@implementation CopyProgram2
- (void)copy {
    Keyboard1 *kb = [Keyboard1 new];
    NSString *data = [kb read];
    if (_networkPrinterFlag == NO) {
        Printer1 *prt = [Printer1 new];
        [prt printData:data];
    } else {
        NetworkPrinter *nwPrt = [NetworkPrinter new];
        [nwPrt printDataToNetwork:data];
    }
}
@end

#pragma mark - Copy Program 3

@interface Scanner : NSObject
- (NSString *)scan;
@end

@implementation Scanner
- (NSString *)scan {
    return @"some data scanned";
}
@end

@interface CopyProgram3 : NSObject
- (void)copy;
@property BOOL networkPrinterFlag;
@property BOOL scannerInputFlag;
@end

@implementation CopyProgram3
- (void)copy {
    NSString *data;
    if (!self.scannerInputFlag) {
        Keyboard1 *kb = [Keyboard1 new];
        data = [kb read];
    } else {
        Scanner *sc = [Scanner new];
        [sc scan];
    }
    if (!self.networkPrinterFlag) {
        Printer1 *prt = [Printer1 new];
        [prt printData:data];
    } else {
        NetworkPrinter *nwPrt = [NetworkPrinter new];
        [nwPrt printDataToNetwork:data];
    }
}
@end

#pragma Copy Program Using Protocols

@protocol Inputable <NSObject>
- (NSString *)read;
@end

@protocol Outputable <NSObject>
- (void)writeData:(NSString *)data;
@end


@interface Scanner2 : NSObject<Inputable>
@end

@implementation Scanner2

- (NSString *)read {
    return [self scan];
}
- (NSString *)scan {
    return @"some data scanned";
}
@end

@interface NetworkPrinter2: NSObject<Outputable>
- (void)printDataToNetwork:(NSString *)data;
@end

@implementation NetworkPrinter2

- (void)writeData:(NSString *)data {
    [self printDataToNetwork:data];
}
- (void)printDataToNetwork:(NSString *)data {
    NSLog(@"===>> %s %@", __PRETTY_FUNCTION__, data);
}
@end

@interface Keyboard2 : NSObject<Inputable>
- (NSString *)read;
@end
@implementation Keyboard2
- (NSString *)read {
    return @"==>>> some data";
}
@end

@interface Printer2 : NSObject<Outputable>
- (void)printData:(NSString *)data;
@end
@implementation Printer2
- (void)writeData:(NSString *)data {
    [self printData:data];
}
- (void)printData:(NSString *)data {
    NSLog(@"%@", data);
}
@end

@interface CopyProgram4 : NSObject
- (void)copyWithInput:(id<Inputable>)input output:(id<Outputable>)output;
@end

@implementation CopyProgram4
- (void)copyWithInput:(id<Inputable>)input output:(id<Outputable>)output {
    NSString *data = [input read];
    [output writeData:data];
}
@end

@interface ProtocolTests : XCTestCase
@end

@implementation ProtocolTests


- (void)testCopy1 {
    CopyProgram1 *cp = [CopyProgram1 new];
    [cp copy];
}

- (void)testCopy2 {
    CopyProgram2 *cp = [CopyProgram2 new];
    cp.networkPrinterFlag = YES;
    [cp copy];
}

- (void)testCopy3 {
    CopyProgram3 *cp = [CopyProgram3 new];
    cp.networkPrinterFlag = YES;
    cp.scannerInputFlag = YES;
    [cp copy];
}

- (void)testCopy4 {
    CopyProgram4 *cp = [CopyProgram4 new];
    [cp copyWithInput:[Keyboard2 new] output:[NetworkPrinter2 new]];
}



@end
