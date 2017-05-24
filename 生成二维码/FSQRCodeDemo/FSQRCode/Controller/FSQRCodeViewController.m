//
//  FSQRCodeViewController.m
//  FSQRCodeDemo
//
//  Created by LKLFS on 16/1/29.
//  Copyright © 2016年 LKLFS. All rights reserved.
//

#import "FSQRCodeViewController.h"

#define kThemeColor [UIColor colorWithRed:223 / 255.0 green:24 / 255.0 blue:37 / 255.0 alpha:1.0];
#define TBackColor [UIColor colorWithRed:37 / 255.0 green:54 / 155.0 blue:167 / 255.0 alpha:1.0];
#define MAINSCREEN [UIScreen mainScreen]

@interface FSQRCodeViewController ()
@property (strong, nonatomic) NSString *code;

@property (strong, nonatomic) UIImageView    *qrCodeImageView;
@property (strong, nonatomic) UIImageView    *barCodeImageView;


@end

@implementation FSQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TBackColor;
    [self createNavigationUI];
    [self createUI];
    
    // 生成条形码和二维码
    [self createQRCodeAndBarCode];
}

/**
 *  设置导航栏
 */
- (void)createNavigationUI
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationItem.title = @"拉卡拉";
    UIBarButtonItem *refreshButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh.png"] style:UIBarButtonItemStyleDone target:self action:@selector(reloadQRCodeAndBarCode)];
    self.navigationItem.rightBarButtonItem = refreshButtonItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationController.navigationBar.backgroundColor = kThemeColor;
    self.navigationController.navigationBar.barTintColor = kThemeColor;
}

/**
 *  设置控件UI
 */
- (void)createUI
{
    UIView * QRBackView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, MAINSCREEN.bounds.size.width - 100, MAINSCREEN.bounds.size.width - 100)];
    
    _barCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 150, MAINSCREEN.bounds.size.width - 160, MAINSCREEN.bounds.size.width/3)];
    _barCodeImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_barCodeImageView];
    
    _qrCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 280, MAINSCREEN.bounds.size.width - 160, MAINSCREEN.bounds.size.width - 160)];
    //_qrCodeImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_qrCodeImageView];
}

- (void)createQRCodeAndBarCode
{
    NSString * str = @"01029874565";
    _barCodeImageView.image = [self generateBarCode:str width:300 height:80];
    _code = @"猴赛雷";
    _qrCodeImageView.image = [self generateQRCode:_code width:300 height:300];
}
#pragma mark - 加载条形码以及二维码
- (void)reloadQRCodeAndBarCode {
    NSLog(@"刷新啦~~~~");
    [self createQRCodeAndBarCode];
//    [MBProgressHUD showHUDAddedTo:_rectView animated:YES];
//    [_progressTimer invalidate];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    [self loadDataFromService];
}

#pragma mark - 生成条形码以及二维码

// 参考文档
// https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html

- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    // 1. 创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3.设置数据
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.输出的二维码
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

/**
 * 生成条形码
 */
- (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成条形码
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

@end
