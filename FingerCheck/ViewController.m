//
//  ViewController.m
//  FingerCheck
//
//  Created by Mac on 2018/7/30.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "FingerCheckUnitl.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic,strong)UIButton *fingerPrintIcon;
@property (nonatomic,strong)UIButton *referenceBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.fingerPrintIcon];
    [self.view addSubview:self.referenceBtn];
}
- (void)referenceBtnAction:(UIButton *)btn{
    [FingerCheckUnitl fingerCheckWithAlertTitle:@"使用指纹一键登录" WithFailBtnTitle:@"使用密码校验" WithResultBlock:^(BOOL Success, NSError *err, NSString *resultStr) {
        NSLog(@"%@",resultStr);
    }];
}
- (UIButton *)fingerPrintIcon
{
    if (!_fingerPrintIcon) {
        _fingerPrintIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fingerPrintIcon setImage:[UIImage imageNamed:@"open_lock_way_finger"] forState:UIControlStateNormal];
        _fingerPrintIcon.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _fingerPrintIcon.bounds = CGRectMake(0, 0, Width/2.0, Height/4);
        _fingerPrintIcon.center = self.view.center;
        [_fingerPrintIcon addTarget:self action:@selector(fingerPrintIconAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_fingerPrintIcon];
    }
    return _fingerPrintIcon;
}
- (void)fingerPrintIconAction:(UIButton *)btn
{
    [self referenceBtnAction:_referenceBtn];
}
- (UIButton *)referenceBtn
{
    if (!_referenceBtn) {
        _referenceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_referenceBtn setTitle:@"点击验证指纹" forState:UIControlStateNormal];
        [_referenceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referenceBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:204/255.0 blue:173/255.0 alpha:1]];
        _referenceBtn.layer.cornerRadius = 5;
        _referenceBtn.layer.masksToBounds = YES;
        _referenceBtn.bounds = CGRectMake(0, 0, Width/2, 30);
        _referenceBtn.center = CGPointMake(self.view.center.x, _fingerPrintIcon.center.y+Height/8);
        _referenceBtn.titleLabel.adjustsFontSizeToFitWidth = true;
        [_referenceBtn addTarget:self action:@selector(referenceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_referenceBtn];
    }
    return _referenceBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
