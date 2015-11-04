//
//  CDPDefaultModeViewController.m
//  keyboard
//
//  Created by 柴东鹏 on 15/9/3.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPDefaultModeViewController.h"

#import "CDPMonitorKeyboard.h"//引入头文件

@interface CDPDefaultModeViewController () <CDPMonitorKeyboardDelegate>//协议非必须遵守,看需求

@end

@implementation CDPDefaultModeViewController{
    UILabel *_topLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(30,70,60,30)];
    [backButton setTitle:@"<返回" forState:UIControlStateNormal];
    backButton.backgroundColor=[UIColor cyanColor];
    [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    _topLabel=[[UILabel alloc] initWithFrame:CGRectMake(100,60,150,30)];
    _topLabel.textColor=[UIColor redColor];
    _topLabel.text=@"自动注册键盘监听";
    [self.view addSubview:_topLabel];

    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(14,105,self.view.bounds.size.width-28,100)];
    label.font=[UIFont systemFontOfSize:14];
    label.backgroundColor=[UIColor whiteColor];
    label.numberOfLines=0;
    label.text=@"模式说明\ndefaultMode下输入视图在主视图上,高于键盘不会监听，低于键盘才会监听，且具体高出键盘多少高度可以自定义,demo中为0";
    [self.view addSubview:label];
    
    UITextField *textField1=[[UITextField alloc] initWithFrame:CGRectMake(14,230,self.view.bounds.size.width-28,30)];
    textField1.backgroundColor=[UIColor whiteColor];
    textField1.font=[UIFont systemFontOfSize:14];
    textField1.text=@"输入视图超过键盘";
    [self.view addSubview:textField1];
    
    UITextField *textField2=[[UITextField alloc] initWithFrame:CGRectMake(14,self.view.bounds.size.height-100,self.view.bounds.size.width-28,30)];
    textField2.backgroundColor=[UIColor whiteColor];
    textField2.font=[UIFont systemFontOfSize:14];
    textField2.text=@"输入视图低于键盘";
    [self.view addSubview:textField2];
    
    //此模式输入视图在主视图上，superView传self.view
    [[CDPMonitorKeyboard defaultMonitorKeyboard] sendValueWithSuperView:self.view higherThanKeyboard:0 andMode:CDPMonitorKeyboardDefaultMode navigationControllerTopHeight:0];
    //代理看需求，非必须
    [CDPMonitorKeyboard defaultMonitorKeyboard].delegate=self;
}

#pragma mark CDPMonitorKeyboardDelegate
//系统键盘出现
-(void)didWhenKeyboardWillShow:(NSNotification *)notification{
    NSLog(@"键盘出现了");
    _topLabel.text=@"键盘出现";
}
//系统键盘消失
-(void)didWhenKeyboardWillHide:(NSNotification *)notification{
    NSLog(@"键盘消失了");
    _topLabel.text=@"键盘消失";
}



//点击空白处结束编辑状态
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//返回
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
