
//
//  AbleChangeDirectionAnimator.m
//  RingFlipper
//
//  Created by Inba on 2015/04/17.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "AbleChangeDirectionAnimator.h"

@implementation AbleChangeDirectionAnimator{
    CAAnimationGroup *_groupAnimation;
    CALayer *_addedLayer;
    
    BOOL _isStarted;
    BOOL _isReverse;
    NSDate *_preAddedAnimationDate;
    
    __weak NSObject *_preDeligate;
    float _animePreStartSecond;
}

-(id)initWithGroupAnimation:(CAAnimationGroup *)groupAnimation AddLayer:(CALayer *)addedLayer{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _groupAnimation = groupAnimation;
    _groupAnimation.speed = 1;
    _preDeligate = groupAnimation.delegate;
    _addedLayer = addedLayer;
    _groupAnimation.delegate = self;
    return self;
}

-(void)startAnimation{
    _preAddedAnimationDate = [NSDate date];
    _isStarted = YES;
    [_addedLayer addAnimation:_groupAnimation forKey:@"cancelKey"];

}

-(void)reverse{
    float intervalFroPreAddedAnime = -(NSTimeInterval)[_preAddedAnimationDate timeIntervalSinceNow];
    float rateOfProgression = [self rateOfProgressionInTermOfFirstDirectionAtIntervalFromPreAddedAnime:intervalFroPreAddedAnime];
    

    if ([self isReverse] == YES) {
        _groupAnimation.beginTime =[_addedLayer convertTime:CACurrentMediaTime()-rateOfProgression*_groupAnimation.duration fromLayer:nil];
        _animePreStartSecond = rateOfProgression*_groupAnimation.duration;
    }else{
        _groupAnimation.beginTime =[_addedLayer convertTime:CACurrentMediaTime()-_groupAnimation.duration +rateOfProgression*_groupAnimation.duration fromLayer:nil];
        _animePreStartSecond = _groupAnimation.duration - rateOfProgression*_groupAnimation.duration;
    }

    _groupAnimation.speed = -_groupAnimation.speed;
    [self startAnimation];
}

-(float)rateOfProgressionInTermOfFirstDirectionAtIntervalFromPreAddedAnime:(float)interval{//現在最初に設定したゴールまで何％近づいたか
    if ([self isReverse] == YES) {
        return (_groupAnimation.duration - _animePreStartSecond - interval)/_groupAnimation.duration;
    }else{
        return (_animePreStartSecond+interval)/_groupAnimation.duration;
    }
}

-(void)removeLayerAfterInterval:(float)interval{
    [_addedLayer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:interval];
    _addedLayer = nil;
    _groupAnimation = nil;
}

-(BOOL)isReverse{
    BOOL isReverse = _groupAnimation.speed == -1 ?YES : NO;
    return isReverse;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

-(void)dealloc{
    NSLog(@"破壊");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
