//
//  ViewController.m
//  CustomPageControlDemo
//
//  Created by DQB on 15/3/3.
//  Copyright (c) 2015年 DQB. All rights reserved.
//

#import "ViewController.h"
#import "CustomPageControl.h"

#define kIphoneScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kIphoneScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController
{
    CustomPageControl   *_pageControl;
    UIScrollView        *_scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kIphoneScreenWidth, kIphoneScreenHeight)];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.contentSize = CGSizeMake(4 * kIphoneScreenWidth, kIphoneScreenHeight);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, kIphoneScreenHeight - 100, kIphoneScreenWidth, 40)];
    _pageControl.numberOfPages = 4;
    _pageControl.currentPage = 0;
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)s {
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(s.frame);
    NSUInteger page = floor((s.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
}

@end
