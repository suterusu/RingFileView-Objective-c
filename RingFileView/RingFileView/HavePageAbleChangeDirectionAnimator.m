//
//  HavePageAbleChangeDirectionAnimator.m
//  RingFlipper
//
//  Created by Inba on 2015/04/17.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "HavePageAbleChangeDirectionAnimator.h"
@implementation HavePageAbleChangeDirectionAnimator
-(void)reverse{
    [super reverse];
    _direction = (_direction+1)%2;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [super animationDidStop:anim finished:flag];
    if (flag) {
        NSInteger setLeftPage = self.isReverse == NO? _leftPage : _preLeftPage;
        NSInteger setRightPage = self.isReverse == NO? _rightPage : _preRightPage;
        [self.deligate finishAnimationSetRightPage:setRightPage LeftPage:setLeftPage DicKey:_dicKey];
    }
}
@end
