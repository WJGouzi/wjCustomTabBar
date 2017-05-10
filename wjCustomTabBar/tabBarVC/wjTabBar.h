//
//  wjTabBar.h
//  wjCustomTabBar
//
//  Created by gouzi on 2017/5/4.
//  Copyright © 2017年 wj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol wjTabBarDelegate <NSObject>

- (void)specailButtonClickAction;

@end

@interface wjTabBar : UITabBar

/** delegate */
@property (nonatomic, weak) id<wjTabBarDelegate> delegate;


@end
