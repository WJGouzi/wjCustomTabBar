//
//  wjTestVC.m
//  wjCustomTabBar
//
//  Created by gouzi on 2017/5/10.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "wjTestVC.h"

@interface wjTestVC ()

@end

@implementation wjTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
