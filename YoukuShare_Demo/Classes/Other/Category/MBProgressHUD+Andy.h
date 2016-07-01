//
//  MBProgressHUD+Andy.h
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Andy)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view shouldAutoRoateAngle:(CGFloat)angle;
+ (void)showError:(NSString *)error toView:(UIView *)view shouldAutoRoateAngle:(CGFloat)angle;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (void)showSuccess:(NSString *)success shouldAutoRoateAngle:(CGFloat)angle;
+ (void)showError:(NSString *)error shouldAutoRoateAngle:(CGFloat)angle;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
