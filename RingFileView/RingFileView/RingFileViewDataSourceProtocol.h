//
//  RingFileViewDataSourceProtocol.h
//  RingFlipper
//
//  Created by Inba on 2015/04/01.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RingFileViewDataSourceProtocol <NSObject>


-(UIImage *)getNextPageImageAtPageIndex:(NSInteger)pageIndex;


@end
