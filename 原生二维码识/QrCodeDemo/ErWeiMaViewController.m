//
//  ErWeiMaViewController.m
//  YouXun
//
//  Created by laouhn on 15/12/22.
//  Copyright © 2015年 Xboker. All rights reserved.
//

#import "ErWeiMaViewController.h"
#import "MBProgressHUD.h"


@interface ErWeiMaViewController ()<UIWebViewDelegate>
///二维码加载在webview上
@property (nonatomic, strong) UIWebView *myWeb;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ErWeiMaViewController

#warning 这里有个坑点.默认算上tabbar高度,如果当前视图控制器不显示tabbar则需要高度添加49!
- (UIWebView *)myWeb {
    if (!_myWeb) {
        self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height )];
    }
    return _myWeb;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTheString];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
}
- (void)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadTheString {
    self.myWeb.delegate = self;
    self.hud = [MBProgressHUD showHUDAddedTo:self.myWeb animated:YES];
    self.hud.labelText = @"loading..";
    self.myWeb.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.myWeb];
    //    [self.myWeb scalesPageToFit];
    [self.myWeb setScalesPageToFit:YES];
    if ([self.myUrl hasPrefix:@"http://"] ) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.myUrl]];
        [self.myWeb loadRequest:request];
    }else {
        [self.myWeb loadHTMLString:[NSString stringWithFormat:@"<span style=\"font-size:40px;\"><span style=\"color:#000000;\">%@</span></span></span>", self.myUrl] baseURL:nil];
    }
    if ([[NSURL URLWithString:self.myUrl] checkResourceIsReachableAndReturnError:nil]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.myUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [self.myWeb loadRequest:request];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    ///超过10s没有响应,或者请求失败
    [self requestFailed];
    [self.hud hide:YES];
}
///请求失败
- (void)requestFailed {
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30)];
    myView.backgroundColor = [UIColor darkGrayColor];
    myView.alpha = 0;
    UILabel *mylable = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, [UIScreen mainScreen].bounds.size.width - 60, 20)];
    mylable.text = @"网络连接失败,请检测网络设置.";
    mylable.textColor = [UIColor whiteColor];
    mylable.font = [UIFont systemFontOfSize:15];
    mylable.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:mylable];
    [self.view addSubview:myView];
    [UIView animateWithDuration:1 animations:^{
        myView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            myView.alpha = 0;
        }];
    }];
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
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com