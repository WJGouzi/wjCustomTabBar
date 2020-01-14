//
//  wjTabBar.m
//  wjCustomTabBar
//
//  Created by gouzi on 2017/5/4.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "wjTabBar.h"

@interface wjTabBar ()

@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation wjTabBar

#pragma mark - 懒加载
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

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self insertBackgroundImageWithFrame:frame];
    }
    return self;
}

- (void)insertBackgroundImageWithFrame:(CGRect)frame {

    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_bg"]];
    img.frame = frame;
    img.contentMode = UIViewContentModeScaleToFill;
    [self insertSubview:img atIndex:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSMutableArray *buttonArray = [NSMutableArray array];
    for (UIView *subview in self.subviews) {
        if (subview.class == NSClassFromString(@"UITabBarButton") || subview.class == NSClassFromString(@"UIButton")) {
            [buttonArray addObject:subview];
        }
    }
    
    for (UIView *subView in self.subviews) { /// 移除上面的横线
        NSString *classname = NSStringFromClass([subView class]);
        if ([classname isEqualToString:@"_UIBarBackground"]) {
            [subView removeFromSuperview];
            break;
        }
    }
    /**** 设置所有UITabBarButton的frame ****/
    // 按钮的尺寸
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    // 按钮索引
    int buttonIndex = 0;
    
    buttonArray = [self sortTabBarBtnArray:buttonArray].copy;
    for (UIView *subview in buttonArray) {
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
    CGFloat imageWith = self.publishButton.imageView.image.size.width;
    CGFloat imageHeight = self.publishButton.imageView.image.size.height;
    CGFloat labelWidth = self.publishButton.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.publishButton.titleLabel.intrinsicContentSize.height;
    CGFloat margin = 2;
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(-labelHeight + margin, 0, 0, -labelWidth);
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight + margin, 0);
    [self.publishButton setImageEdgeInsets:imageEdgeInsets];
    [self.publishButton setTitleEdgeInsets:labelEdgeInsets];
}

/// 对按钮进行排序
- (NSArray *)sortTabBarBtnArray:(NSMutableArray *)btnArr {
    NSComparator cmptor = ^(UIView *obj1, UIView *obj2){
        if (obj1.frame.origin.x < obj2.frame.origin.x) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if (obj1.frame.origin.x > obj2.frame.origin.x) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    [btnArr sortUsingComparator:cmptor];
    return btnArr.copy;
}

#pragma mark - 点击事件
- (void)publishClick {
    NSLog(@"点击了");
    
    if ([self.delegate performSelector:@selector(specailButtonClickAction)]) {
        [self.delegate specailButtonClickAction];
    }
}

@end
