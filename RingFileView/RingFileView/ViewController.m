//
//  ViewController.m
//  RingFileView
//
//  Created by Inba on 2015/04/19.
//  Copyright (c) 2015年 Inba. All rights reserved.
//
#import "ViewController.h"
#import "RingFileView.h"

@interface ViewController (){
    RingFileView *_ringFileView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    _ringFileView = [[RingFileView alloc]initWithOrigin:CGPointMake(10, 10) PaperSize:CGSizeMake(200,300) PaperHoleInsetPersent:0.001 RingRadius:10];
    [self.view addSubview:_ringFileView];
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left)];
    UITapGestureRecognizer *tapright = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right)];
    [_ringFileView.rightBaseView addGestureRecognizer:tapright];
    [_ringFileView.leftBaseView addGestureRecognizer:tapLeft];
    [_ringFileView setRingFileDirection:RightTOLeft];
    _ringFileView.dataSource = self;
    [_ringFileView setEachFrontPageSmallerIndex:0];
    _ringFileView.animationDuration =5;
    
    
}




-(void)right{
    [_ringFileView flipAtDirection:RightTOLeft];
    
}

-(void)left{
    
    [_ringFileView flipAtDirection:LeftToRight];
}

-(UIImage *)getNextPageImageAtPageIndex:(NSInteger)pageIndex{
    NSString *imageName = [NSString stringWithFormat:@"sample%d",pageIndex];
    return [UIImage imageNamed:imageName];
}


@end
