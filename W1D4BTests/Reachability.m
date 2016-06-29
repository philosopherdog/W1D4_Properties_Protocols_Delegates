//
//  Reachability.m
//  W1D4B
//
//  Created by steve on 2016-06-29.
//  Copyright © 2016 steve. All rights reserved.
//

#import "Reachability.h"

@implementation Reachability
- (void)someFakeEvent {
    
    [self.delegate didBecomeReachableByWIFI:self];
    
    if ([self.delegate respondsToSelector:@selector(didBecomeReachableByCellularData:)]) {
        [self.delegate didBecomeReachableByCellularData:self];
    }
}
@end
