//
//  CDPMonitorKeyboard.h
//  keyboard
//
//  Created by 柴东鹏 on 15/4/26.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDPMonitorKeyboard : NSObject

//获取其单例
+(CDPMonitorKeyboard *)defaultMonitorKeyboard;

//键盘出现时调用方法
-(void)keyboardWillShowWithSuperView:(UIView *)superView andNotification:(NSNotification *)notification higherThanKeyboard:(NSInteger)valueOfTheHigher;

//键盘消失时调用方法
-(void)keyboardWillHide;


@end
