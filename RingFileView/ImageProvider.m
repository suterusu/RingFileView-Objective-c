
//
//  ImageProvider.m
//  RingFileView
//
//  Created by Inba on 2015/04/29.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "ImageProvider.h"
#import <UIKit/UIKit.h>

@implementation ImageProvider

-(UIImage *)getNextPageImageAtPageIndex:(NSInteger)pageIndex{
    if (pageIndex > 100) {
        return nil;
    }
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), 0, 0);

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:50];
    [UIColor colorWithWhite:0 alpha:0].setFill;
    [path fill];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:50];
    [UIColor blueColor].setFill;
    [path2 fill];
    
    
    NSString *drawText= [NSString stringWithFormat:@"%ld",pageIndex];
    CGSize textSize =  [drawText sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:50],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [drawText drawAtPoint:CGPointMake(50-textSize.width/2, 50-textSize.height/2) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:50],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    UIImage *returnImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return returnImage;
}

@end
