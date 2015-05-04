//
//  CDPMonitorKeyboard.m
//  keyboard
//
//  Created by 柴东鹏 on 15/4/26.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPMonitorKeyboard.h"

@implementation CDPMonitorKeyboard{
    UIView *_superView;//输入view的父view
    CGRect _superViewOldFrame;
}

//单例化
+(CDPMonitorKeyboard *)defaultMonitorKeyboard{
    static CDPMonitorKeyboard *monitorKeyboard= nil;
    
    @synchronized(self){
        if (!monitorKeyboard) {
            monitorKeyboard=[[self alloc] init];
        }
    }
    return monitorKeyboard;
}


//当键盘出现时调用方法
-(void)keyboardWillShowWithSuperView:(UIView *)superView andNotification:(NSNotification *)notification higherThanKeyboard:(NSInteger)valueOfTheHigher{
    _superView=superView;
    _superViewOldFrame=superView.frame;
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    
    for (UIView *view in superView.subviews) {
        if (view.isFirstResponder==YES) {
            NSInteger value=superView.bounds.size.height-view.frame.origin.y-view.bounds.size.height;
            if (value<height) {
                [UIView animateWithDuration:0.3 animations:^{
                    //防止超出视图最大范围
                    if (value-height-valueOfTheHigher+height<=0) {
                        superView.frame=CGRectMake(0,-height,superView.bounds.size.width,superView.bounds.size.height);
                    }
                    else{
                        superView.frame=CGRectMake(0,value-height-valueOfTheHigher,superView.bounds.size.width,superView.bounds.size.height);
                    }
                }];
            }
        }
    }
    
}

//当键退出时调用
-(void)keyboardWillHide{
    [UIView animateWithDuration:0.3 animations:^{
        if (_superView) {
            _superView.frame=_superViewOldFrame;

        }
    }];
    
    _superView=nil;
}







@end
