//
//  CDPScrollViewModeViewController.m
//  keyboard
//
//  Created by 柴东鹏 on 15/9/3.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPScrollViewModeViewController.h"

#import "CDPMonitorKeyboard.h"//引入头文件

@interface CDPScrollViewModeViewController () <CDPMonitorKeyboardDelegate>//协议非必须遵守,看需求

@end

@implementation CDPScrollViewModeViewController{
    UILabel *_topLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];

    UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(30,60,60,30)];
    [backButton setTitle:@"<返回" forState:UIControlStateNormal];
    backButton.backgroundColor=[UIColor cyanColor];
    [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(14,95,self.view.bounds.size.width-28,100)];
    label.font=[UIFont systemFontOfSize:14];
    label.backgroundColor=[UIColor whiteColor];
    label.numberOfLines=0;
    label.text=@"scrollViewMode下输入视图在scrollView上,效果类似于tableViewMode,超出键盘高度会向下位移,低于键盘会向上位移,即使输入视图未在屏幕显示完全也会自动使其全部显示,出现在键盘上方高度可以自定义,demo中为0";
    [self.view addSubview:label];
    
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(28,200,self.view.bounds.size.width-56,self.view.bounds.size.height-200-10)];
    scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    _topLabel=[[UILabel alloc] initWithFrame:CGRectMake(100,60,150,30)];
    _topLabel.textColor=[UIColor redColor];
    _topLabel.text=@"自动注册键盘监听";
    [self.view addSubview:_topLabel];

    UITextField *textField1=[[UITextField alloc] initWithFrame:CGRectMake(14,10,200,30)];
    textField1.backgroundColor=[UIColor whiteColor];
    textField1.font=[UIFont systemFontOfSize:14];
    textField1.backgroundColor=[UIColor cyanColor];
    textField1.text=@"上方输入视图超过键盘下移(changeWhenHigher=NO取消)";
    [scrollView addSubview:textField1];
    
    UITextField *textField2=[[UITextField alloc] initWithFrame:CGRectMake(14,scrollView.bounds.size.height-80,200,30)];
    textField2.backgroundColor=[UIColor whiteColor];
    textField2.font=[UIFont systemFontOfSize:14];
    textField2.backgroundColor=[UIColor cyanColor];
    textField2.text=@"下方输入视图低于键盘上移";
    [scrollView addSubview:textField2];
    
    //此模式输入视图在scrollView上或其子view中,即其下级体系中,superView传该scrollView
    [[CDPMonitorKeyboard defaultMonitorKeyboard] sendValueWithSuperView:scrollView higherThanKeyboard:0 andMode:CDPMonitorKeyboardScrollViewMode];
    //代理看需求，非必须
    [CDPMonitorKeyboard defaultMonitorKeyboard].delegate=self;

}
-(void)dealloc{
    //清空并重置数据
    [[CDPMonitorKeyboard defaultMonitorKeyboard] clearAll];
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
