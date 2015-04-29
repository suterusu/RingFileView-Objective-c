
//
//  Sample2ViewController.m
//  RingFileView
//
//  Created by Inba on 2015/04/29.
//  Copyright (c) 2015年 Inba. All rights reserved.
//

#import "Sample2ViewController.h"
#import "RingFileView.h"
#import "ImageProvider.h"
@interface Sample2ViewController (){
    RingFileView *_ringFileView;

    ImageProvider *_provider;
    
    float angle;
}

@end

@implementation Sample2ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor grayColor];
    
    _provider = [[ImageProvider alloc]init];
    
    _ringFileView = [[RingFileView alloc]initWithOrigin:CGPointMake(self.view.center.x-250,self.view.center.y-125) PaperSize:CGSizeMake(250,250) PaperHoleInsetPersent:0 RingRadius:5];
    [self.view addSubview:_ringFileView];
    UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(left)];
    UITapGestureRecognizer *tapright = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(right)];
    
    UIPanGestureRecognizer *changeAngle = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeAngle:)];
    

    
    [_ringFileView.rightBaseView addGestureRecognizer:tapright];
    [_ringFileView.leftBaseView addGestureRecognizer:tapLeft];
    
    [_ringFileView addGestureRecognizer:changeAngle];
    
    [_ringFileView setRingFileDirection:RightTOLeft];
    _ringFileView.dataSource = _provider;
    [_ringFileView setEachFrontPageSmallerIndex:0];
    _ringFileView.animationDuration =3;
    [_ringFileView setBaseTransform:CATransform3DMakeRotation(M_PI_2/1.5, 1, 0, 0)];
    _ringFileView.allowStartAnimetionInterval = 0.1;
    
    angle = 1;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)right{
    
    [_ringFileView turnThePageAtDirection:RightTOLeft];
}

-(void)left{
    [_ringFileView turnThePageAtDirection:LeftToRight];
}

-(void)changeAngle:(UIPanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint delta = [recognizer translationInView:_ringFileView.leftBaseView];
        if (delta.y<0) {
            angle+=-0000.1;
        }else if(delta.y>0){
            angle+=0000.1;
        }
        
        NSLog(@"%f",angle);
        [_ringFileView setBaseTransform:CATransform3DMakeRotation(M_PI_2*angle/2, 1, 0, 0)];
        [recognizer setTranslation:CGPointZero inView:_ringFileView.leftBaseView];
    }
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
