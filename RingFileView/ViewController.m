//
//  ViewController.m
//  RingFileView
//
//  Created by Inba on 2015/04/19.
//  Copyright (c) 2015年 Inba. All rights reserved.
//
#import "ViewController.h"
#import "RingFileView.h"
#import "ImageProvider.h"
@interface ViewController (){
    RingFileView *_ringFileView;
    RingFileView *_ringFileView2;
    RingFileView *_ringFileView3;

    ImageProvider *_provider;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor grayColor];
    
    _provider = [[ImageProvider alloc]init];
    
    _ringFileView = [[RingFileView alloc]initWithOrigin:CGPointMake(5,5) PaperSize:CGSizeMake(100,100) PaperHoleInsetPersent:0.001 RingRadius:30];
    [self.view addSubview:_ringFileView];
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left)];
    UITapGestureRecognizer *tapright = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right)];
    [_ringFileView.rightBaseView addGestureRecognizer:tapright];
    [_ringFileView.leftBaseView addGestureRecognizer:tapLeft];
    [_ringFileView setRingFileDirection:RightTOLeft];
    _ringFileView.dataSource = _provider;
    [_ringFileView setEachFrontPageSmallerIndex:0];
    _ringFileView.animationDuration =50;
    [_ringFileView setBaseTransform:CATransform3DMakeRotation(M_PI_2/4, 1, 0, 0)];
    
    _ringFileView2 = [[RingFileView alloc]initWithOrigin:CGPointMake(CGRectGetMaxX(_ringFileView.frame)+20, 10) PaperSize:CGSizeMake(100,100) PaperHoleInsetPersent:0.001 RingRadius:5];
    [self.view addSubview:_ringFileView2];
    UITapGestureRecognizer *tapLeft2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left2)];
    UITapGestureRecognizer *tapright2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right2)];
    [_ringFileView2.rightBaseView addGestureRecognizer:tapright2];
    [_ringFileView2.leftBaseView addGestureRecognizer:tapLeft2];
    [_ringFileView2 setRingFileDirection:RightTOLeft];
    _ringFileView2.dataSource = self;
    [_ringFileView2 setEachFrontPageSmallerIndex:0];
    _ringFileView2.animationDuration =50;
    [_ringFileView2 setBaseTransform:CATransform3DMakeRotation(M_PI_2/4, 1, 0, 0)];
    

    
    _ringFileView3 = [[RingFileView alloc]initWithOrigin:CGPointMake(30, 250) PaperSize:CGSizeMake(250,30) PaperHoleInsetPersent:0.001 RingRadius:5];
    [self.view addSubview:_ringFileView3];
    UITapGestureRecognizer *tapLeft3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left3)];
    UITapGestureRecognizer *tapright3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right3)];
    [_ringFileView3.rightBaseView addGestureRecognizer:tapright3];
    [_ringFileView3.leftBaseView addGestureRecognizer:tapLeft3];
    [_ringFileView3 setRingFileDirection:RightTOLeft];
    _ringFileView3.dataSource = self;
    [_ringFileView3 setEachFrontPageSmallerIndex:0];
    _ringFileView3.animationDuration =50;
    [_ringFileView3 setBaseTransform:CATransform3DMakeRotation(M_PI_2/2, 1, 0, 0)];
    
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


-(void)right3{
    [_ringFileView3 flipAtDirection:RightTOLeft];
}

-(void)left3{
    [_ringFileView3 flipAtDirection:LeftToRight];
}

-(UIImage *)getNextPageImageAtPageIndex:(NSInteger)pageIndex{
    NSString *imageName = [NSString stringWithFormat:@"th_th_fuga_%ld.jpg",pageIndex];
    return [UIImage imageNamed:imageName];
}


@end
