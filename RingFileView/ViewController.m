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
    RingFileView *_ringFileView2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor grayColor];
    
    _ringFileView = [[RingFileView alloc]initWithOrigin:CGPointMake(10, 100) PaperSize:CGSizeMake(150,200) PaperHoleInsetPersent:0.001 RingRadius:1];
    [self.view addSubview:_ringFileView];
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left)];
    UITapGestureRecognizer *tapright = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right)];
    [_ringFileView.rightBaseView addGestureRecognizer:tapright];
    [_ringFileView.leftBaseView addGestureRecognizer:tapLeft];
    [_ringFileView setRingFileDirection:RightTOLeft];
    _ringFileView.dataSource = self;
    [_ringFileView setEachFrontPageSmallerIndex:0];
    _ringFileView.animationDuration =3;
    
    
    _ringFileView2 = [[RingFileView alloc]initWithOrigin:CGPointMake(10, 400) PaperSize:CGSizeMake(100,100) PaperHoleInsetPersent:0.001 RingRadius:5];
    [self.view addSubview:_ringFileView2];
    UITapGestureRecognizer *tapLeft2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left2)];
    UITapGestureRecognizer *tapright2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right2)];
    [_ringFileView2.rightBaseView addGestureRecognizer:tapright2];
    [_ringFileView2.leftBaseView addGestureRecognizer:tapLeft2];
    [_ringFileView2 setRingFileDirection:RightTOLeft];
    _ringFileView2.dataSource = self;
    [_ringFileView2 setEachFrontPageSmallerIndex:0];
    _ringFileView2.animationDuration =3;
    [_ringFileView setA:CATransform3DMakeRotation(M_PI_2/2, 1, 0, 0)];
    
}




-(void)right{
    [_ringFileView flipAtDirection:RightTOLeft];
    
}

-(void)left{
    
    [_ringFileView flipAtDirection:LeftToRight];
}

-(void)right2{
    [_ringFileView2 flipAtDirection:RightTOLeft];
}

-(void)left2{
    [_ringFileView2 flipAtDirection:LeftToRight];
}

-(UIImage *)getNextPageImageAtPageIndex:(NSInteger)pageIndex{
    NSString *imageName = [NSString stringWithFormat:@"th_th_fuga_%d.jpg",pageIndex];
    return [UIImage imageNamed:imageName];
}


@end
