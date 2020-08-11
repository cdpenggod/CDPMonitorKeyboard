//
//  CDPMonitorKeyboard.h
//  keyboard
//
//  Created by CDP on 15/4/26.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

enum {
    CDPMonitorKeyboardDefaultMode       = 0, //一般模式 (输入视图在 UIView上 或其 子view 中,即其 下级体系中)
    CDPMonitorKeyboardTableViewMode     = 1, //tableView模式 (输入视图在 tableView上 或其 子view 中,即其 下级体系中)
    CDPMonitorKeyboardScrollViewMode    = 2  //scrollView模式 (输入视图在 scrollView上 或其 子view 中,即其 下级体系中)
};
typedef NSInteger CDPMonitorKeyboardMode; //模式,与传入的 superView 对应



@protocol CDPMonitorKeyboardDelegate <NSObject>

/// 系统键盘出现时
/// @param notification 通知notification
- (void)didWhenKeyboardWillShow:(NSNotification *)notification;

/// 系统键盘消失时
/// @param notification 通知notification
- (void)didWhenKeyboardWillHide:(NSNotification *)notification;

@end


@interface CDPMonitorKeyboard : NSObject //主类

/// 代理
@property (nonatomic,weak) id <CDPMonitorKeyboardDelegate> delegate;

/// 如果使用页面中写了 scrollViewDidScroll 等 滑动回调，且里面有 取消键盘 的代码，必须判断 isShowKeyboard 为 NO 时才取消键盘
///
/// 例如    if ([CDPMonitorKeyboard defaultMonitorKeyboard].isShowKeyboard == NO) {
///         **此处为取消键盘代码**
///      }
@property (nonatomic, assign, readonly) BOOL isShowKeyboard;

/// 当输入 view 高于键盘高度时, 是否仍然自动改变高度 (默认为 NO ,仅限 tableViewMode\scrollViewMode)
@property (nonatomic, assign) BOOL changeWhenHigher;

/// 单例
+ (CDPMonitorKeyboard *)defaultMonitorKeyboard;

/// 自动监听调用方法 (仅需调用一次，如果 改变参数 需要重新调用传参, 替换之前的)
///
/// 一般模式时 superView 传输入视图所在视图即可
/// tableView 模式时 superView 传输入视图所在的 tableView
/// scrollView 模式时 superView 传输入视图所在的 scrollView
///
/// @param superView 输入视图所在视图,与 mode 对应
/// @param valueOfHigher 为输入视图需要高出键盘的高度
/// @param mode 为当前需要的模式(目前共有三种)
- (void)sendValueWithSuperView:(UIView *)superView higherThanKeyboard:(NSInteger)valueOfHigher andMode:(CDPMonitorKeyboardMode)mode;

/// 清空并重置所有相关数据，防止因为单例造成内存问题 （如果没有替换参数解除引用，可用此方法在 dealloc 中调用)
- (void)clearAll;




@end
