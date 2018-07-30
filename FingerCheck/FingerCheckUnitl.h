//
//  FingerCheckUnitl.h
//  FingerCheck
//
//  Created by Mac on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FingerCheckUnitl : NSObject
/**
 * 指纹校验
 * @param reason  
 * @param title
 * @param resultBlock 结果回调
 */
+ (void)fingerCheckWithAlertTitle:(NSString *)reason
                 WithFailBtnTitle:(NSString *)title
                  WithResultBlock:(void(^)(BOOL Success , NSError *err, NSString *resultStr))resultBlock;
@end
