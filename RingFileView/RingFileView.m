//
//  RingFileView.m
//  RingFlipper
//
//  Created by Inba on 2015/04/01.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "RingFileView.h"
#import "HavePageAbleChangeDirectionAnimator.h"
#import "OneSideNoAllowDoubleObjectLeftAndRightQueueMnager.h"
typedef void (^AfterAnimationBlock)();

@implementation RingFileView{
    CALayer *_baseLayer;
    
    CGRect _leftPaperFrame;
    CGRect _rightPaperFrame;
    
    NSInteger _leftPage;
    NSInteger _rightPage;
    
    float _insetPersent;
    float _ringRadius;
    enum FlipDirection _ringFileDirection;
    
    UIView*_leftBaseView;
    UIView*_rightBaseView;
    
    CALayer *_leftImageLayer;
    CALayer *_rightImageLayer;
    
    
    NSMutableDictionary *_currentAddingAnimeDic;
    OneSideNoAllowDoubleObjectLeftAndRightQueueMnager *_EachDirectionAnimeKeyQueue;
    
    HavePageAbleChangeDirectionAnimator *_last;
    
    CATransform3D _baseTransform;
}


- (instancetype)initWithOrigin:(CGPoint)origin PaperSize:(CGSize)size PaperHoleInsetPersent:(float)insetPersent RingRadius:(float)ringRadius
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, (size.width*(1.0-insetPersent))*2+ringRadius*2,size.height)];
    if (self) {
        _baseTransform = CATransform3DIdentity;
        
        _baseLayer = [[CALayer alloc]init];
        _baseLayer.frame = self.bounds;
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/500;
        _baseLayer.sublayerTransform = transform;
        [self.layer addSublayer:_baseLayer];
        
        
        _leftPaperFrame = CGRectMake(0, 0, size.width, size.height);
        _rightPaperFrame = CGRectMake( (size.width*(1-insetPersent))+ringRadius*2,0-size.width*insetPersent,size.width, size.height);
        
        _insetPersent = insetPersent;
        _ringRadius = ringRadius;

        _leftImageLayer = [[CALayer alloc]init];
        _leftImageLayer.frame = _leftPaperFrame;
        [_baseLayer addSublayer:_leftImageLayer];
        _leftImageLayer.zPosition = 1;
        
        _rightImageLayer = [[CALayer alloc]init];
        _rightImageLayer.frame = _rightPaperFrame;
        [_baseLayer addSublayer:_rightImageLayer];
        _rightImageLayer.zPosition = 1;
        
        _rightBaseView = [[UIView alloc]initWithFrame:_rightPaperFrame];
        _leftBaseView = [[UIView alloc]initWithFrame:_leftPaperFrame];
        [self addSubview:_rightBaseView];
        [self addSubview:_leftBaseView];
        
        _animationDuration = 3;
        _currentAddingAnimeDic = [NSMutableDictionary dictionary];
        
        _EachDirectionAnimeKeyQueue = [[OneSideNoAllowDoubleObjectLeftAndRightQueueMnager alloc]init];
        
    }
    
    return self;
}

-(void)setA:(CATransform3D)transform{
    _baseTransform = transform;
    _rightImageLayer.transform = transform;
    _leftImageLayer.transform = transform;
    self.transform = CATransform3DGetAffineTransform(transform);
    [self setNeedsDisplay];
}

-(void)setRingFileDirection:(enum FlipDirection)direction{
    _ringFileDirection = direction;
}
-(void)setEachFrontPageSmallerIndex:(NSInteger)page{
    switch (_ringFileDirection) {
        case RightTOLeft:{
            _rightPage = page;
            _leftPage = page+1;
            break;
        }
        case LeftToRight:{
            _leftPage = page;
            _rightPage = page+1;
            break;
        }
    }

    _leftImageLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_leftPage].CGImage;
    _rightImageLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_rightPage].CGImage;
    
}


-(void)flipAtDirection:(enum FlipDirection)direction{
    enum QueueSide side = [self directionToSide:direction];
    if (_currentAddingAnimeDic.count > 0 && [_EachDirectionAnimeKeyQueue elementAtSide:!side] != nil) {
         HavePageAbleChangeDirectionAnimator *lastPushedAnime = [_currentAddingAnimeDic objectForKey:[_EachDirectionAnimeKeyQueue elementAtSide:!side]];
        [lastPushedAnime reverse];
        
        if (lastPushedAnime.firstDirection == direction) {
            _leftPage = lastPushedAnime.leftPage;
            _rightPage = lastPushedAnime.rightPage;
        }else{
            _leftPage = lastPushedAnime.preLeftPage;
            _rightPage = lastPushedAnime.preRightPage;
        }
        
        [_EachDirectionAnimeKeyQueue changeSideObject:[_EachDirectionAnimeKeyQueue elementAtSide:!side] AtSide:side];
        return;
    }
    
    
    //引数の方向でページをめくる時、ページ数はどのように加算されるか
    NSInteger addAfterFlipNumber = direction == _ringFileDirection ? -1:1;
    
    if (addAfterFlipNumber == 1) {
       // NSLog(@"ページ増減");
    }else{
        //NSLog(@"ページ減少");
    }
    
    //アニメ終了後の右ページと左ページのページ数
    NSInteger nextRightPage = _rightPage +addAfterFlipNumber*2;
    NSInteger nextLeftPage = _leftPage +addAfterFlipNumber*2;
    
    CALayer *animationLayer = [self makeFlipAnimationLayerAtDirection:direction];
    
    CAAnimationGroup *parentAnime = [self getFlipAnimationAtDirection:direction AddLayer:animationLayer];
    parentAnime.delegate = self;
    parentAnime.speed = -1;
    HavePageAbleChangeDirectionAnimator *ableChangeAnimator = [[HavePageAbleChangeDirectionAnimator alloc] initWithGroupAnimation:parentAnime AddLayer:animationLayer];
    ableChangeAnimator.direction = direction;
    ableChangeAnimator.firstDirection = direction;
    ableChangeAnimator.rightPage = nextRightPage;
    ableChangeAnimator.leftPage = nextLeftPage;
    ableChangeAnimator.preRightPage = _rightPage;
    ableChangeAnimator.preLeftPage = _leftPage;

    _last = ableChangeAnimator;
    
    NSString *key = [self makeRandumString];
    ableChangeAnimator.dicKey = key;

    ableChangeAnimator.deligate = self;
    [ableChangeAnimator startAnimation];
    
    
    [_currentAddingAnimeDic setObject:ableChangeAnimator forKey:key];
    [_EachDirectionAnimeKeyQueue addObject:key AtSide:(enum QueueSide)direction];
    
    _rightPage += addAfterFlipNumber*2;
    _leftPage +=addAfterFlipNumber*2;
}

-(BOOL)isCurrentAnimation{
    if (_currentAddingAnimeDic.count == 0) {
        return NO;
    }else{
        return YES;
    }
    
}
//private

-(CALayer *)makeFlipAnimationLayerAtDirection:(enum FlipDirection)direction{
    //引数の方向でページをめくる時、ページ数はどのように加算されるか
    NSInteger addAfterFlipNumber = direction == _ringFileDirection ? -1:1;

    //アニメーションを付加するレイヤーの生成
    CATransformLayer *transformLayer = [[CATransformLayer alloc]init];
    
    CALayer *frontPaperLayer = [[CALayer alloc]init];
    frontPaperLayer.zPosition = 0.5;
    
    CALayer *reversePaperLayer = [[CALayer alloc]init];
    reversePaperLayer.zPosition = 0;
    reversePaperLayer.anchorPoint = CGPointMake(0.5, 0.5);
    reversePaperLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    
    [transformLayer addSublayer:frontPaperLayer];
    [transformLayer addSublayer:reversePaperLayer];
    
    [_baseLayer addSublayer:transformLayer];
    
    
    if (direction == RightTOLeft) {//回転の基軸　アニメーションレイヤーの裏表の画像とそのレイヤーの下にあるレイヤーの画像設定
        transformLayer.anchorPoint = CGPointMake(_insetPersent, 0.5);
        frontPaperLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_rightPage].CGImage;
        reversePaperLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_rightPage+addAfterFlipNumber].CGImage;
        _rightImageLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_rightPage+addAfterFlipNumber+addAfterFlipNumber].CGImage;
    }else{
        transformLayer.anchorPoint = CGPointMake(1-_insetPersent, 0.5);
        frontPaperLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_leftPage].CGImage;
        reversePaperLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_leftPage+addAfterFlipNumber].CGImage;
        _leftImageLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:_leftPage+addAfterFlipNumber+addAfterFlipNumber].CGImage;
    }
    
    transformLayer.frame = direction == RightTOLeft ? _rightPaperFrame:_leftPaperFrame;
    frontPaperLayer.frame = transformLayer.bounds;
    reversePaperLayer.frame = transformLayer.bounds;
    
    

    
    return transformLayer;
}

-(CAAnimationGroup *)getFlipAnimationAtDirection:(enum FlipDirection)direction AddLayer:(CALayer *)layer{
    NSInteger baseMultiple = direction == RightTOLeft ? -1:1;
    
    CABasicAnimation *animationPosition = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animationPosition.byValue = [NSNumber numberWithFloat:baseMultiple*_ringRadius*2];
    animationPosition.duration = _animationDuration;
    
    /*
    CAKeyframeAnimation *animationTransFrom = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    animationTransFrom.additive = YES;
    animationTransFrom.values = @[@0,@(baseMultiple*M_PI/2.0),@(baseMultiple*M_PI)];
    animationTransFrom.keyTimes = @[@0,@(0.5),@1];
    animationTransFrom.duration = _animationDuration;
    */
    
    CAKeyframeAnimation *animationTransFrom = [CAKeyframeAnimation animationWithKeyPath:@"transform"];



    NSValue *a = [NSValue valueWithCATransform3D:CATransform3DConcat(_baseTransform,layer.transform)];
    NSValue *b = [NSValue valueWithCATransform3D:
                      CATransform3DConcat(CATransform3DMakeRotation(baseMultiple*M_PI/2.0, 0, 1, 0),CATransform3DConcat(layer.transform, _baseTransform))];
    NSValue *c = [NSValue valueWithCATransform3D:
                  CATransform3DConcat(CATransform3DMakeRotation(baseMultiple*M_PI, 0, 1, 0),CATransform3DConcat(layer.transform, _baseTransform))];
    animationTransFrom.values = @[a,b,c];
    animationTransFrom.keyTimes = @[@0,@(0.5),@1];
    animationTransFrom.duration = _animationDuration;
    
     
    CAKeyframeAnimation *animationZPotisiont = [CAKeyframeAnimation animationWithKeyPath:@"zPosition"];
    animationZPotisiont.values = @[@1,[NSNumber numberWithFloat:_ringRadius],@1];
    animationZPotisiont.keyTimes = @[@0,@(0.5),@1];
    animationZPotisiont.duration = _animationDuration;
    
    CAAnimationGroup *parentAnimation = [CAAnimationGroup animation];
    parentAnimation.animations = @[animationPosition,animationTransFrom,animationZPotisiont];
    parentAnimation.duration = _animationDuration;
    parentAnimation.fillMode = kCAFillModeForwards;
    parentAnimation.removedOnCompletion = NO;
    parentAnimation.fillMode = kCAFillModeForwards;
    
    
    return parentAnimation;

    
}




-(void)finishAnimationSetRightPage:(NSInteger)rightPage LeftPage:(NSInteger)leftPage DicKey:(NSString *)key{
    HavePageAbleChangeDirectionAnimator *animator = [_currentAddingAnimeDic objectForKey:key];
    
    switch (animator.direction) {
        case RightTOLeft:{
            [animator removeLayerAfterInterval:0.2];
            _leftImageLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:leftPage].CGImage;
            break;
        }
        case LeftToRight:{
            [animator removeLayerAfterInterval:0.2];
            _rightImageLayer.contents = (id)[_dataSource getNextPageImageAtPageIndex:rightPage].CGImage;
            break;
        }
    }
    [_currentAddingAnimeDic removeObjectForKey:key];
    [_EachDirectionAnimeKeyQueue removeAtSide:[self directionToSide:animator.direction]];
}

-(enum QueueSide)directionToSide:(enum FlipDirection)direction{
    if (direction == RightTOLeft) {
        return QueueSideRight;
    }else{
        return QueueSideLeft;
    }
}

-(NSString *)makeRandumString{
    short a= rand();
    return [NSString stringWithFormat:@"%d",a];
}
@end
