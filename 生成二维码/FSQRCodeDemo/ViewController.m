//
//  ViewController.m
//  FSQRCodeDemo
//
//  Created by LKLFS on 16/1/27.
//  Copyright © 2016年 LKLFS. All rights reserved.
//

#import "ViewController.h"
#import "FSQRCodeViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    FSQRCodeViewController * _QRCodeViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI
{
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"生成二维码" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(onClike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)onClike
{
    _QRCodeViewController = [[FSQRCodeViewController alloc] init];
    [self.navigationController pushViewController:_QRCodeViewController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
