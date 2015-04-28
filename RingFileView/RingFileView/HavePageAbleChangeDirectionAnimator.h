//
//  HavePageAbleChangeDirectionAnimator.h
//  RingFlipper
//
//  Created by Inba on 2015/04/17.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "AbleChangeDirectionAnimator.h"

@interface HavePageAbleChangeDirectionAnimator : AbleChangeDirectionAnimator

@property NSInteger direction;
@property NSInteger firstDirection;

@property NSInteger leftPage;
@property NSInteger rightPage;
@property NSInteger preLeftPage;
@property NSInteger preRightPage;
@property NSString *dicKey;
-(id)initWithGroupAnimation:(CAAnimationGroup *)groupAnimation AddLayer:(CALayer *)addedLayer;
//警告　groupAnimationにデリゲートを設定していた場合はそれが解除される
@end
