//
//  ViewController.m
//  LLCollectionViewCellScaleDemo
//
//  Created by linling on 2019/3/5.
//  Copyright © 2019 llmodule. All rights reserved.
//

#import "ViewController.h"

#import "LLScaleScrollView.h"

@interface ViewController () <LLScaleScrollViewDelegate>

@property (nonatomic, strong) LLScaleScrollView *cv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置卡片浏览器
    _cv = [[LLScaleScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 137)];
    _cv.items = @[@"1",@"1",@"1",@"1",@"1"];
    _cv.delegate = self;
    //分页切换
    _cv.pagingEnabled = YES;
    //设置初始位置，默认为0
    _cv.selectedIndex = 0;
    [self.view addSubview:_cv];
}

#pragma mark CardSwitchDelegate

- (void)XLCardSwitchDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
    
}


@end
