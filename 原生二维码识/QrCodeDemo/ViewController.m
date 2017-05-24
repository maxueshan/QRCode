//
//  ViewController.m
//  QrCodeDemo
//
//  Created by moneyShop on 16/3/15.
//  Copyright © 2016年 xboker. All rights reserved.
//

#import "ViewController.h"
#import "SweepViewController.h"


@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *qrCodeField;
///显示二维码的UIImageView
@property (nonatomic, strong) UIImageView *qrCodeImageV;

@property (weak, nonatomic) IBOutlet UIButton *scanningQR;
@property (weak, nonatomic) IBOutlet UIButton *creatQR;
/**
 *  newGet
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutContraint;







@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.qrCodeImageV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 4, 300, [UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.width / 2)];
    [self.view addSubview:self.qrCodeImageV];
    NSLog(@"%f-------%f", self.qrCodeImageV.frame.origin.y, self.qrCodeField.frame.origin.y);
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)scanningQrCode:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        UIAlertController *altC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查设备相机!" preferredStyle:UIAlertControllerStyleAlert];
        [altC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:altC animated:YES completion:nil];
        return;
    }else {
        SweepViewController *sweepV = [[SweepViewController alloc] init];
        [self.navigationController pushViewController:sweepV animated:YES];
    }
 
}

- (IBAction)creatQrCode:(id)sender {
    [self.view endEditing:YES];
    self.layoutContraint.constant = 50.f;
    [self creatQrCodeAction];
}
///创建二维码的过程
- (void)creatQrCodeAction {
    if (self.qrCodeField.text.length != 0) {
        NSLog(@"%@", self.qrCodeField.text);
        ///生成二维码,原生态生成二维码需要导入CoreImage.framework
        //二维码滤镜
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        //恢复滤镜的默认属性
        [filter setDefaults];
        //*****************************************************************//
        //如果是从外界传递来的字符串这里将外界传递来的字符串转换为data即可.
        //*****************************************************************//
        
        //字符串转换为data
        NSData *data = [self.qrCodeField.text dataUsingEncoding:NSUTF8StringEncoding];
        //通过KVO设置滤镜inputmessage数据
        [filter setValue:data forKey:@"inputMessage"];
        //获得滤镜输出的图像
        CIImage *outPutImage = [filter outputImage];
        //将CIImage转换成UImage并展示
        self.qrCodeImageV.image = [self createNonInterpolatedUIImageFormCIImage:outPutImage withSize:100.0];
        self.qrCodeImageV.layer.shadowOffset = CGSizeMake(5, 5);
        self.qrCodeImageV.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.qrCodeImageV.layer.shadowOpacity = 0.2;
    }else {
        ///为空不生成
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.layoutContraint.constant = 50.f;
    return [textField resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.layoutContraint.constant = -50.f;
    return YES;
}

#warning 此方法流程
///将数据转换为二维码图片  ////改变二维码大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.layoutContraint.constant = 50.f;
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com