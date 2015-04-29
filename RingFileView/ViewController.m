//
//  ViewController.m
//  RingFileView
//
//  Created by Inba on 2015/04/19.
//  Copyright (c) 2015年 Inba. All rights reserved.
//
#import "ViewController.h"
#import "SampleIndexTableViewController.h"

@interface ViewController (){

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    SampleIndexTableViewController *vc = [[SampleIndexTableViewController alloc]init];
    
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    
    
    [self presentViewController:navi animated:NO completion:nil];
}

@end
