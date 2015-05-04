//
//  ViewController.m
//  keyboard
//
//  Created by 柴东鹏 on 15/4/26.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "ViewController.h"

#import "CDPMonitorKeyboard.h"//引入头文件

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(0,400,self.view.bounds.size.width,30)];
    textField.backgroundColor=[UIColor greenColor];
    textField.text=@"这个高度设为刚好超过键盘,类似评论框等";
    [self.view addSubview:textField];
    
    UITextField *textField2=[[UITextField alloc] initWithFrame:CGRectMake(10,450,300,30)];
    textField2.backgroundColor=[UIColor yellowColor];
    textField2.text=@"高于键盘的具体高度可自定义";
    [self.view addSubview:textField2];
    
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(20,160,200,60)];
    textView.backgroundColor=[UIColor cyanColor];
    textView.font=[UIFont systemFontOfSize:16];
    textView.text=@"若控件高度大于键盘则无变化~~~~~~~~~~~~";
    [self.view addSubview:textView];
    
    
    

}


#pragma mark 键盘监听方法设置
//当键盘出现时调用
-(void)keyboardWillShow:(NSNotification *)aNotification{
    //第一个参数写输入view的父view即可，第二个写监听获得的notification，第三个写希望高于键盘的高度(只在被键盘遮挡时才启用,如控件未被遮挡,则无变化)
    //如果想不通输入view获得不同高度，可自己在此方法里分别判断区别
    [[CDPMonitorKeyboard defaultMonitorKeyboard] keyboardWillShowWithSuperView:self.view andNotification:aNotification higherThanKeyboard:0];
    
}
//当键退出时调用
-(void)keyboardWillHide:(NSNotification *)aNotification{
    [[CDPMonitorKeyboard defaultMonitorKeyboard] keyboardWillHide];
}



//dealloc中需要移除监听
-(void)dealloc{
    //移除监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    //移除监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


//点击空白处结束编辑状态
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
