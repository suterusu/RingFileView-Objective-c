//
//  LeftQueueAndRightQueueMnager.h
//  RingFlipper
//
//  Created by Inba on 2015/04/18.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import <Foundation/Foundation.h>
enum QueueSide {QueueSideLeft,QueueSideRight};
@interface LeftAndRightQueueMnager : NSObject
//二つ、左と右にキューがあり、それを管理するクラス

-(BOOL)isContainObject:(id)object AtSide:(enum QueueSide)side;
-(void)addObject:(id)object AtSide:(enum QueueSide)side;
-(void)removeAtSide:(enum QueueSide)side;
-(void)removeObject:(id)object AtSide:(enum QueueSide)side;
-(id)elementAtSide:(enum QueueSide)side;

@end
