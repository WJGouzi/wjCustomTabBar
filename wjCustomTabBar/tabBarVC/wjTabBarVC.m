//
//  wjTabBarVC.m
//  wjCustomTabBar
//
//  Created by gouzi on 2017/5/4.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "wjTabBarVC.h"
#import "wjMainNavVC.h"
#import "wjTabBar.h"
#import "wjTestVC.h"

@interface wjTabBarVC () <wjTabBarDelegate>

@end

@implementation wjTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBar];
}


- (void)setTabBar {
    /**** 添加子控制器 ****/
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tab_buddy_nor" selectedImage:@"tab_qworld_nor"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"新帖" image:@"tab_me_nor" selectedImage:@"tab_recent_nor"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"关注" image:@"tab_recent_nor" selectedImage:@"tab_buddy_nor"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"我" image:@"tab_me_nor" selectedImage:@"tab_buddy_nor"];
    [self setValue:[[wjTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //    vc.view.backgroundColor = wjRandomColor;  // 设置背景为随机色
    vc.title = title;
    if (image.length) { // 图片名有具体值，判断图片传入值是空还是nil
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    wjMainNavVC *nav = [[wjMainNavVC alloc] initWithRootViewController:vc];
//    nav.tabBarItem.title = [NSString stringWithFormat:@"vc-%@",title];
//    nav.tabBarItem.badgeValue = @"10";
    [self addChildViewController:nav];
}


#pragma mark - delegate
- (void)specailButtonClickAction {
    [self presentViewController:[[wjTestVC alloc] init] animated:YES completion:nil];
}


@end
