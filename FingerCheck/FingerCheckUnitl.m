//
//  FingerCheckUnitl.m
//  FingerCheck
//
//  Created by Mac on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "FingerCheckUnitl.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation FingerCheckUnitl
+ (void)fingerCheckWithAlertTitle:(NSString *)reason WithFailBtnTitle:(NSString *)title WithResultBlock:(void(^)(BOOL Success , NSError *err, NSString *resultStr))resultBlock{
    LAContext *context = [LAContext new];
    context.localizedFallbackTitle = title;
//    context.localizedCancelTitle = @"取笑";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            resultBlock(success,error,[self referenceErrorCode:error.code fallBack:title]);
        }];
    }else{
        NSLog(@"设备不支持指纹识别");
        dispatch_async(dispatch_get_main_queue(), ^{
            resultBlock(NO,error,[self referenceErrorCode:error.code fallBack:title]);
        });
    }
}
#pragma mark 返回错误参考信息
+ (NSString *)referenceErrorCode:(NSInteger)errorCode fallBack:(NSString *)fallBackStr
{
    switch (errorCode) {
        case LAErrorAuthenticationFailed:
            return @"授权失败";
            break;
        case LAErrorUserCancel:
            return @"用户取消验证Touch ID";
            break;
        case LAErrorUserFallback:
            return fallBackStr;
            break;
        case LAErrorSystemCancel:
            return @"系统取消授权，如其他APP切入";
            break;
        case LAErrorPasscodeNotSet:
            return @"系统未设置密码";
            break;
        case LAErrorTouchIDNotAvailable:
            return @"设备Touch ID不可用，例如未打开";
            break;
        case LAErrorTouchIDNotEnrolled:
            return @"设备Touch ID不可用，用户未录入";
            break;
        case LAErrorTouchIDLockout:
            return @"身份验证未成功,多次使用Touch ID失败";
            break;
        case LAErrorAppCancel:
            return @"认证被取消的应用";
            break;
        case LAErrorInvalidContext:
            return @"授权对象失效";
            break;
        case LAErrorNotInteractive:
            return @"APP未完全启动,调用失败";
            break;
            
        default:
            return @"验证成功";
            break;
    }
}
@end
