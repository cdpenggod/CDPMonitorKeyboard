//
//  CDPTableVIewModeViewController.m
//  keyboard
//
//  Created by 柴东鹏 on 15/9/3.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "CDPTableVIewModeViewController.h"

#import "CDPMonitorKeyboard.h"//引入头文件

@interface CDPTableVIewModeViewController () <UITableViewDataSource,UITableViewDelegate,CDPMonitorKeyboardDelegate>//协议非必须遵守,看需求

@end

@implementation CDPTableVIewModeViewController{
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
    label.text=@"tableViewMode下输入视图在tableView的cell上,超出键盘高度会向下位移(changeWhenHigher=NO取消),低于键盘会向上位移,即使输入视图未在屏幕显示完全也会自动使其全部显示,出现在键盘上方高度可以自定义,demo中为0";
    [self.view addSubview:label];
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(28,200,self.view.bounds.size.width-56,self.view.bounds.size.height-200-10) style:UITableViewStylePlain];
    tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    tableView.backgroundColor=[UIColor clearColor];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
    _topLabel=[[UILabel alloc] initWithFrame:CGRectMake(100,60,150,30)];
    _topLabel.textColor=[UIColor redColor];
    _topLabel.text=@"自动注册键盘监听";
    [self.view addSubview:_topLabel];

    
    //此模式输入视图在tableView上或其子view中,即其下级体系中,superView传该tableView
    [[CDPMonitorKeyboard defaultMonitorKeyboard] sendValueWithSuperView:tableView higherThanKeyboard:0 andMode:CDPMonitorKeyboardTableViewMode];
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
#pragma mark tableViewDelegate dataSource
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//row数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CDPTableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CDPTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(10,5,cell.bounds.size.width-20,20)];
        textField.backgroundColor=[UIColor greenColor];
        textField.text=[NSString stringWithFormat:@"输入栏%ld",(long)indexPath.row];
        [cell.contentView addSubview:textField];
        
    }
    
    return cell;
}
//tableView滑动时
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当isShowKeyboard==YES时,tableView滑动不收起键盘
    //如果项目里写了tableView滑动取消键盘的代码，必须在相关函数里面加入此判断
    if ([CDPMonitorKeyboard defaultMonitorKeyboard].isShowKeyboard==YES) {
        return;
    }
    [self.view endEditing:YES];
}
#pragma mark - 点击事件
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
