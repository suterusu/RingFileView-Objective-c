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

@property UIView *leftBaseView;
@property UIView *rightBaseView;
@property (weak) NSObject<RingFileViewDataSourceProtocol> *dataSource;

- (instancetype)initWithOrigin:(CGPoint)origin PaperSize:(CGSize)size PaperHoleInsetPersent:(float)insetPersent RingRadius:(float)ringRadius;
-(void)flipAtDirection:(enum FlipDirection)direction;
-(void)setEachFrontPageSmallerIndex:(NSInteger)page;
-(void)setRingFileDirection:(enum FlipDirection)direction;
-(BOOL)isCurrentAnimation;

@end
