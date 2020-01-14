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

// 底部安全区域高度
#define SafeArea_DownHeight  (Screen_Height >= 812 ? 34 : 0)
// 屏幕宽度
#define Screen_Width [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface wjTabBarVC () <wjTabBarDelegate>

@end

@implementation wjTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBar];
}

- (void)viewDidLayoutSubviews {
    // 重新定义tabbar的高度
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    frame.size.height = 72;
    frame.origin.y = Screen_Height - frame.size.height - SafeArea_DownHeight;
    self.tabBar.frame = frame;
}

- (void)setTabBar {
    /**** 添加子控制器 ****/
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"精华" image:@"tab_buddy_nor" selectedImage:@"tab_qworld_nor"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"新帖" image:@"tab_me_nor" selectedImage:@"tab_recent_nor"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"关注" image:@"tab_recent_nor" selectedImage:@"tab_buddy_nor"];
    [self setupOneChildViewController:[[UITableViewController alloc] init] title:@"我" image:@"tab_me_nor" selectedImage:@"tab_buddy_nor"];
    wjTabBar *myTabbar = [[wjTabBar alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 72)];
    myTabbar.delegate = self;
    [self setValue:myTabbar forKeyPath:@"tabBar"];
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
