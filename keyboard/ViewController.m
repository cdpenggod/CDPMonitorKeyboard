//
//  ViewController.m
//  keyboard
//
//  Created by 柴东鹏 on 15/4/26.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import "ViewController.h"
#import "CDPDefaultModeViewController.h"
#import "CDPTableVIewModeViewController.h"
#import "CDPScrollViewModeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(14,100,self.view.bounds.size.width-28,140)];
    label.backgroundColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:14];
    label.numberOfLines=0;
    label.text=@"CDPMonitorKeyboard共分为三种模式\n单例化一行代码自动监听键盘高度,无需自己对键盘进行监听\n如果需要监听键盘实现自己的方法，可遵守CDPMonitorKeyboardDelegate\n详情看demo";
    [self.view addSubview:label];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-30,300,60,30)];
    button.backgroundColor=[UIColor whiteColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTitle:@"一般模式" forState:UIControlStateNormal];
    
    for (NSInteger i=0;i<3;i++) {
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-70,300+40*i,140,30)];
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        switch (i) {
            case 0:
                [button setTitle:@"一般模式" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(defaultClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [button setTitle:@"tableView模式" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(tableViewClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [button setTitle:@"scrollView模式" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(scrollViewClick) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                break;
        }
        [self.view addSubview:button];
    }
    

}

-(void)defaultClick{
    CDPDefaultModeViewController *vc=[[CDPDefaultModeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)tableViewClick{
    CDPTableVIewModeViewController *vc=[[CDPTableVIewModeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)scrollViewClick{
    CDPScrollViewModeViewController *vc=[[CDPScrollViewModeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
