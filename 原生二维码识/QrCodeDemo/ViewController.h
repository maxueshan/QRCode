//
//  ViewController.h
//  QrCodeDemo
//
//  Created by moneyShop on 16/3/15.
//  Copyright © 2016年 xboker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 *  直接引入其他工程时把需要生成二维码的字符串传递过来就可
 */

@property (nonatomic, copy) NSString *qrCodeString;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com