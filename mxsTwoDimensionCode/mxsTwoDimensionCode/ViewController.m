//
//  ViewController.m
//  mxsTwoDimensionCode
//
//  Created by xueshan on 16/9/22.
//  Copyright © 2016年 xueshan. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"
#import "ScanningViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *generateBtn;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageView.image = [QRCodeGenerator qrImageForString:@"https://www.baidu.com" imageSize:_imageView.frame.size.width  ];
    CGRect rrr = _label.frame;
    
    NSString *str = @"HelloHelloHelloHelloHello" ;
    // 动态计算label宽度
    CGRect rect = [str boundingRectWithSize:CGSizeMake(500, 20) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    
    NSLog(@"啦啦啦%f",rect.size.width);
    _label.frame = CGRectMake(rrr.origin.x, rrr.origin.y, size.width, size.height);
    NSLog(@"啊啊啊啊%f",_label.frame.size.width);
    _label.adjustsFontSizeToFitWidth = 1;
    _label.backgroundColor = [UIColor redColor];
    _label.text = str;
    
    
}

- (IBAction)generateTwoDimension:(id)sender {
    NSDate *date = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyyMMdd-hhmmss";
    NSString *str = [fm stringFromDate:date];
    NSLog(@"111:%@",str);
//    @"https://www.baidu.com" 
    _imageView.image = [QRCodeGenerator qrImageForString:str imageSize:_imageView.frame.size.width  ];
    
}


- (IBAction)swipeTwoDimension:(id)sender {
    
    ScanningViewController *vc = [[ScanningViewController alloc]init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
