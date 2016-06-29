//
//  Reachability.h
//  W1D4B
//
//  Created by steve on 2016-06-29.
//  Copyright © 2016 steve. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;
@protocol ReachabilityDelegate <NSObject>
- (void)didBecomeReachableByWIFI:(Reachability *)reachability;
@optional
- (void)didBecomeReachableByCellularData:(Reachability *)reachability;
@end

@interface Reachability : NSObject
@property (nonatomic, weak) id<ReachabilityDelegate>delegate;
- (void)someFakeEvent;
@end
