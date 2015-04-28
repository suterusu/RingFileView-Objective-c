//
//  AbleChangeDirectionAnimator.h
//  RingFlipper
//
//  Created by Inba on 2015/04/17.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtocolAbleChangeDirectionAnimator.h"

@interface AbleChangeDirectionAnimator : NSObject
-(id)initWithGroupAnimation:(CAAnimationGroup *)groupAnimation AddLayer:(CALayer *)addedLayer;
-(void)startAnimation;
-(void)reverse;
-(BOOL)isReverse;
-(void)removeLayerAfterInterval:(float)interval;

@property (weak) NSObject<ProtocolAbleChangeDirectionAnimator> *deligate;
@end
