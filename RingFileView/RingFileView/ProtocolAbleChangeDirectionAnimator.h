//
//  ProtocolAbleChangeDirectionAnimator.h
//  RingFlipper
//
//  Created by Inba on 2015/04/17.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocolAbleChangeDirectionAnimator <NSObject>
-(void)finishAnimationSetRightPage:(NSInteger)rightPage LeftPage:(NSInteger)leftPage DicKey:(NSString *)key;
@end
