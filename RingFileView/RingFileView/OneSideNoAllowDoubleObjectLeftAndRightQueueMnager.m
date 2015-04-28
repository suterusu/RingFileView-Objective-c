//
//  OneSideNoAllowDoubleObjectLeftAndRightQueueMnager.m
//  RingFlipper
//
//  Created by Inba on 2015/04/19.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "OneSideNoAllowDoubleObjectLeftAndRightQueueMnager.h"

@implementation OneSideNoAllowDoubleObjectLeftAndRightQueueMnager

-(void)addObject:(id)object AtSide:(enum QueueSide)side{
    if ([self isContainObject:object AtSide:side]) {
        abort();
    }
    [super addObject:object AtSide:side];
}

-(void)changeSideObject:(id)object AtSide:(enum QueueSide)side{
    id changeElement = [self elementAtSide:side];
    if (side == QueueSideRight) {
        [self addObject:object AtSide:QueueSideRight];
        [self removeObject:object AtSide:QueueSideLeft];

    }else{
        [self addObject:object AtSide:QueueSideLeft];
        [self removeObject:object AtSide:QueueSideRight];
    }
}




@end
