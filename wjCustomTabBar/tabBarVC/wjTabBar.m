//
//  wjTabBar.m
//  wjCustomTabBar
//
//  Created by gouzi on 2017/5/4.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "wjTabBar.h"
#import "wjTestVC.h"

@interface wjTabBar ()

@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation wjTabBar



- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"tab_recent_nor"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tab_qworld_nor"] forState:UIControlStateHighlighted];
        [_publishButton setTitle:@"special" forState:UIControlStateNormal];
        [_publishButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_publishButton setBackgroundColor:[UIColor blueColor]];
        // 发布按钮的点击事件
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_publishButton];
    }
    return _publishButton;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    /**** 设置所有UITabBarButton的frame ****/
    // 按钮的尺寸
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    // 按钮索引
    int buttonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton
        //   if (![@"UITabBarButton" isEqualToString:NSStringFromClass(subview.class)]) continue;
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        // 设置frame
        CGFloat buttonX = buttonIndex * buttonW;
        // 把发布按钮的位置预留出来
        if (buttonIndex >= 2) { // 右边的2个UITabBarButton
            buttonX += buttonW;
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 增加索引
        buttonIndex++;
    }
    
    /**** 设置中间的发布按钮的frame ****/
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
}


- (void)publishClick {
    NSLog(@"点击了");
    
    if ([self.delegate performSelector:@selector(specailButtonClickAction)]) {
        [self.delegate specailButtonClickAction];
    }
}

@end
