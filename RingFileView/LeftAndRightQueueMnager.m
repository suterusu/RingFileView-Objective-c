
//
//  LeftQueueAndRightQueueMnager.m
//  RingFlipper
//
//  Created by Inba on 2015/04/18.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "LeftAndRightQueueMnager.h"

@implementation LeftAndRightQueueMnager{
    NSMutableArray *_rightArray;
    NSMutableArray *_leftArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rightArray = [NSMutableArray array];
        _leftArray = [NSMutableArray array];
    }
    return self;
}

-(void)addObject:(id)object AtSide:(enum QueueSide)side{
    if (side == QueueSideRight) {
        if ([_rightArray containsObject:object]) {
            abort();
        }
        
        [_rightArray addObject:object];
    }else{
        if ([_leftArray containsObject:object]) {
            abort();
        }
        
        [_leftArray addObject:object];
    }
}

-(void)removeAtSide:(enum QueueSide)side{
    if (side == QueueSideRight) {
        [_rightArray removeObjectAtIndex:0];
    }else{
        [_leftArray removeObjectAtIndex:0];
    }
}

-(void)removeObject:(id)object AtSide:(enum QueueSide)side{
    if (side == QueueSideRight) {
        [_rightArray removeObject:object];
    }else{
        [_leftArray removeObject:object];
    }
}

-(BOOL)isContainObject:(id)object AtSide:(enum QueueSide)side{
    if (side == QueueSideRight) {
        return [_rightArray containsObject:object];
    }else{
        return [_leftArray containsObject:object];
    }
}

-(id)elementAtSide:(enum QueueSide)side{
    if (side == QueueSideRight) {
        return [_rightArray lastObject];
    }else{
        return [_leftArray lastObject];
    }
}

@end
