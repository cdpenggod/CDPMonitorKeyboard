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
    
    CDPMonitorKeyboardMode _mode;//当前模式
    
    NSInteger _valueOfHigher;//输入视图需要高出键盘的高度

    NSInteger _topHeight;//navigationBar高度+状态栏高度(20)
    
}

//单例化
+(CDPMonitorKeyboard *)defaultMonitorKeyboard{
    static CDPMonitorKeyboard *monitorKeyboard= nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        monitorKeyboard=[[self alloc] init];

    });
    return monitorKeyboard;
}
-(instancetype)init{
    if (self=[super init]) {
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}
-(void)dealloc{
    //取消监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}
//自动监听调用方法(仅需调用一次，若果需要改变参数再调用)
-(void)sendValueWithSuperView:(UIView *)superView higherThanKeyboard:(NSInteger)valueOfHigher andMode:(CDPMonitorKeyboardMode)mode navigationControllerTopHeight:(NSInteger)topHeight{
    _superView=superView;
    _valueOfHigher=valueOfHigher;
    _mode=mode;
    _topHeight=topHeight;
}
#pragma mark - 监听系统键盘
//键盘出现
-(void)keyboardWillShow:(NSNotification *)notification{
    [self didKeyboardWillShowWithNotification:notification];
    if (_delegate) {
        [_delegate didWhenKeyboardWillShow:notification];
    }
}
//键盘消失
-(void)keyboardWillHide:(NSNotification *)notification{
    [self didKeyboardWillHide];
    if (_delegate) {
        [_delegate didWhenKeyboardWillHide:notification];
    }
}
#pragma mark - 键盘出现和消失调用方法
//当键盘出现时调用方法
-(void)didKeyboardWillShowWithNotification:(NSNotification *)notification{
    //获取键盘的高度
    NSDictionary *userInfo=[notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSInteger height = keyboardRect.size.height;
    
    switch (_mode) {
        case CDPMonitorKeyboardDefaultMode:
            [self defaultModeWithKeyboardHeight:height];
            break;
        case CDPMonitorKeyboardTableViewMode:
            [self tableViewModeWithKeyboardHeight:height];
            break;
        case CDPMonitorKeyboardScrollViewMode:
            [self scrollViewModeWithKeyboardHeight:height];
            break;
            
        default:
            NSLog(@"CDPMonitorKeyboardMode模式设定错误");
            break;
    }
    
    
    
}
//当键退出时调用
-(void)didKeyboardWillHide{
    [UIView animateWithDuration:0.3 animations:^{
        if (_superView) {
            _superView.transform=CGAffineTransformIdentity;
        }
    }];
}
#pragma mark - 键盘各模式
//一般模式下
-(void)defaultModeWithKeyboardHeight:(NSInteger)height{
    _superView.transform=CGAffineTransformIdentity;
    
    for (UIView *view in _superView.subviews) {
        if (view.isFirstResponder==YES) {
            NSInteger value=_superView.bounds.size.height-_topHeight-(view.frame.origin.y+view.bounds.size.height);
            if (value<height) {
                [UIView animateWithDuration:0.3 animations:^{
                    //防止超出屏幕最大范围
                    if ((height-value)+_valueOfHigher-height>0) {
                        _superView.transform=CGAffineTransformMakeTranslation(0,-height);
                    }
                    else{
                        _superView.transform=CGAffineTransformMakeTranslation(0,value-height-_valueOfHigher);
                    }
                }];
            }
        }
    }

}
//tableView模式下
-(void)tableViewModeWithKeyboardHeight:(NSInteger)height{
    _superView.transform=CGAffineTransformIdentity;

    if (_mode==CDPMonitorKeyboardTableViewMode) {
        UITableView *tableView=(UITableView *)_superView;
        for (UITableViewCell *cell in [[_superView.subviews objectAtIndex:0] subviews]) {
            for (UIView *view in [[cell.subviews objectAtIndex:0] subviews]) {
                if (view.isFirstResponder==YES) {
                    UIView *cellView=view.superview.superview;
                    float value1=cellView.frame.origin.y+view.bounds.size.height+view.frame.origin.y-tableView.contentOffset.y;
                    float value2=tableView.bounds.size.height-value1;
                    if (value2<0) {
                        tableView.contentOffset=CGPointMake(0,-value2);
                        value2=0;
                    }
                    float value=value2+([UIScreen mainScreen].bounds.size.height-tableView.bounds.size.height-tableView.frame.origin.y-_topHeight);
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        _superView.transform=CGAffineTransformMakeTranslation(0,value-height-_valueOfHigher);
                    }];
                }
            }
        }
    }
}
//scrollView模式下
-(void)scrollViewModeWithKeyboardHeight:(NSInteger)height{
    _superView.transform=CGAffineTransformIdentity;
    
    if (_mode==CDPMonitorKeyboardScrollViewMode) {
        UIScrollView *scrollView=(UIScrollView *)_superView;
        for (UIView *view in [_superView subviews]) {
            if (view.isFirstResponder==YES) {
                float value1=view.bounds.size.height+view.frame.origin.y-scrollView.contentOffset.y;
                float value2=scrollView.bounds.size.height-value1;
                if (value2<0) {
                    scrollView.contentOffset=CGPointMake(0,-value2);
                    value2=0;
                }
                float value=value2+([UIScreen mainScreen].bounds.size.height-scrollView.bounds.size.height-scrollView.frame.origin.y-_topHeight);
                
                [UIView animateWithDuration:0.3 animations:^{
                    _superView.transform=CGAffineTransformMakeTranslation(0,value-height-_valueOfHigher);
                }];
            }
        }
    }
}











@end
