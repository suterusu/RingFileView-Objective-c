//
//  RingFileView.h
//  RingFlipper
//
//  Created by Inba on 2015/04/01.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingFileViewDataSourceProtocol.h"
#import "ProtocolAbleChangeDirectionAnimator.h"
@interface RingFileView : UIView<ProtocolAbleChangeDirectionAnimator>
enum FlipDirection {LeftToRight,RightTOLeft};

@property NSInteger animationDuration;

@property (readonly) UIView *leftBaseView;
@property (readonly) UIView *rightBaseView;

@property (weak) NSObject<ProtocolRingFileViewDataSource> *dataSource;

//displaying page After finishing  Animation turnning the page
//アニメーション終了後に表示される予定のページ
@property (readonly) NSInteger leftPage;
@property (readonly) NSInteger rightPage;
@property NSTimeInterval allowStartAnimetionInterval;

- (instancetype)initWithOrigin:(CGPoint)origin PaperSize:(CGSize)size PaperHoleInsetPersent:(float)insetPersent RingRadius:(float)ringRadius;
-(void)turnThePageAtDirection:(enum FlipDirection)direction;
-(void)setEachFrontPageSmallerIndex:(NSInteger)page;
-(void)setRingFileDirection:(enum FlipDirection)direction;
-(BOOL)isCurrentAnimation;
-(void)setBaseTransform:(CATransform3D)transform;

@end
