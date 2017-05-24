//
//  ScanningViewController.m
//  mxsTwoDimensionCode
//
//  Created by xueshan on 16/9/22.
//  Copyright © 2016年 xueshan. All rights reserved.
//
//
//
//  ios 原生扫描二维码
//
//
#import "ScanningViewController.h"

#import <AVFoundation/AVFoundation.h>

#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height


@interface ScanningViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>

@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureDevice *device;
@property(nonatomic,strong)AVCaptureDeviceInput *input;
@property(nonatomic,strong)AVCaptureMetadataOutput *output;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preview;

@property(nonatomic,strong)UIView *line;

@end

@implementation ScanningViewController

#pragma mark Setter & Getter
//- (UIView *)line{
//    if (_line == nil) {
//        _line = [[UIView alloc] initWithFrame:CGRectMake((Screen_width-180)/2, Screen_height/3.f, 180, 4)];
//        _line.backgroundColor = [UIColor whiteColor];
//    }
//    return _line;
//}

- (AVCaptureDevice *)device{
    if (_device == nil) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}
- (AVCaptureMetadataOutput *)output{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//        [_output setRectOfInterest:CGRectMake(50, 150, Screen_width - 100, Screen_height - 300)];
    }
    return _output;
}
- (AVCaptureSession *)session{
    if (_session == nil) {
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
        
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)preview{
    if (_preview == nil) {
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        [_preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        _preview.frame = CGRectMake(0, 0, Screen_width, Screen_height);
    }
    return _preview;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupCamera];
    
}

- (void)setupCamera{
    [self.view.layer insertSublayer:self.preview atIndex:0];
//    [self.view.layer addSublayer:self.preview];
    self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;
    
    [self.session startRunning];
    
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            NSString *stringValue = [metadataObject stringValue];
            if (stringValue != nil) {
                [self.session stopRunning];
                //扫描结果
//                self.scannedResult=stringValue;
                NSLog(@"%@",stringValue);
            }
            
        }
    }
    
    
}



- (IBAction)swipeAgain:(id)sender {
    [self.session startRunning];
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
