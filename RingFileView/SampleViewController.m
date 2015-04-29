//
//  SampleViewController.m
//  RingFileView
//
//  Created by Inba on 2015/04/29.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "SampleViewController.h"
#import "RingFileView.h"

@interface SampleViewController (){
    RingFileView *_ringFileView;
    NSMutableArray *imageArray;
}

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    self.view.backgroundColor = [UIColor grayColor];
    imageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<=100; i++) {
        NSString *imageName = [NSString stringWithFormat:@"th_th_fuga_%ld.jpg",i+1];
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    
    
    _ringFileView = [[RingFileView alloc]initWithOrigin:CGPointMake(self.view.center.x-150,self.view.center.y-100) PaperSize:CGSizeMake(150,200) PaperHoleInsetPersent:0 RingRadius:5];
    _ringFileView.dataSource = self;
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left)];
    UITapGestureRecognizer *tapright = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right)];
    
    UIPanGestureRecognizer *panRight = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRightView:)];
    
    UIPanGestureRecognizer *panLeft = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panLeftView:)];
    
    [_ringFileView.rightBaseView addGestureRecognizer:tapright];
    [_ringFileView.leftBaseView addGestureRecognizer:tapLeft];
    
    [_ringFileView.rightBaseView addGestureRecognizer:panRight];
    [_ringFileView.leftBaseView addGestureRecognizer:panLeft];
    
    [_ringFileView setRingFileDirection:RightTOLeft];
    [_ringFileView setEachFrontPageSmallerIndex:3];
    _ringFileView.animationDuration =2;
    [_ringFileView setBaseTransform:CATransform3DMakeRotation(M_PI_2/2, 1, 0, 0)];
    _ringFileView.allowStartAnimetionInterval = 0.2;
    [self.view addSubview:_ringFileView];
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)right{
    if (_ringFileView.rightPage <=1) {
        return;
    }
    [_ringFileView turnThePageAtDirection:RightTOLeft];
}

-(void)left{
    if (_ringFileView.rightPage >=99) {
        return;
    }
    [_ringFileView turnThePageAtDirection:LeftToRight];
}

-(void)panLeftView:(UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint delta = [recognizer translationInView:_ringFileView.leftBaseView];
        if (delta.x<0) {
            [self left];
        }
        [recognizer setTranslation:CGPointZero inView:_ringFileView.leftBaseView];
    }
    
}


-(void)panRightView:(UIPanGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint delta = [recognizer translationInView:_ringFileView.rightBaseView];
        if (delta.x>0) {
            [self right];
        }
        [recognizer setTranslation:CGPointZero inView:_ringFileView.rightBaseView];
    }
    
}
-(UIImage *)getNextPageImageAtPageIndex:(NSInteger)pageIndex{
    return imageArray[pageIndex];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
