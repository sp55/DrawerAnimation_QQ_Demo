//
//  ViewController.m
//  DrawerAnimation_QQ_Demo
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 AlezJi. All rights reserved.
//
//http://www.jianshu.com/p/5e713940f207
//极简实现抽屉效果/动画

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIView *leftView;//左侧的View
@property (nonatomic,strong) UIView *rightView;//右侧的View
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //底部的ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width+100, 0);
    scrollView.contentOffset = CGPointMake(100, 0);
    
    //左侧的View
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];
    scrollView.delegate = self;
    _leftView.backgroundColor = [UIColor purpleColor];
    [scrollView addSubview:_leftView];
    
    //右侧的View
    _rightView = [[UIView alloc]initWithFrame:CGRectMake(100, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView addSubview:_rightView];
    _rightView.backgroundColor = [UIColor orangeColor];
}

//开始滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xy = scrollView.contentOffset.x/_leftView.frame.size.width;
    //0.75+0.25*xy = 最小缩放尺寸+滑动控制的缩放尺寸
    _rightView.transform = CGAffineTransformMakeScale(0.75+0.25*xy,0.75+0.25*xy);
}

//结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat leftViewWidth = _leftView.frame.size.width;
    if (scrollView.contentOffset.x < leftViewWidth*0.5)
    {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake(leftViewWidth, 0);
        }];
    }
}



@end
