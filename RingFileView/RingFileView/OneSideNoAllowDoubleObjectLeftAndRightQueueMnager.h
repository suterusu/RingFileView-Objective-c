//
//  OneSideNoAllowDoubleObjectLeftAndRightQueueMnager.h
//  RingFlipper
//
//  Created by Inba on 2015/04/19.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "LeftAndRightQueueMnager.h"

@interface OneSideNoAllowDoubleObjectLeftAndRightQueueMnager : LeftAndRightQueueMnager
//それぞれのキュー内に同じオブジェクトがダブる事を許さない

-(void)addObject:(id)object AtSide:(enum QueueSide)side;

-(void)changeSideObject:(id)object AtSide:(enum QueueSide)side;
//指定した側のオブジェクトを取り出し逆側へエンキューする

@end
