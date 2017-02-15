//
//  CustomNavigationController.m
//  RACDemoOne
//
//  Created by ZhongMeng on 17/2/9.
//  Copyright © 2017年 ZhangRui. All rights reserved.
//

#import "CustomNavigationController.h"

#import "customNavigationBar.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    customNavigationBar *customnaviBar = (customNavigationBar *)self.navigationBar;
    [customnaviBar setBackgroundImage:[self imageWithColor:[UIColor orangeColor] height:64] forBarMetrics:UIBarMetricsDefault];
    
    customnaviBar.shadowImage = [UIImage new];
}



- (UIImage *)imageWithColor:(UIColor *)color height:(CGFloat)height {
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
