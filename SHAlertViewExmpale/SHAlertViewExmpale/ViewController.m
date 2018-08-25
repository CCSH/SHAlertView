//
//  ViewController.m
//  SHAlertViewExmpale
//
//  Created by CSH on 2018/8/24.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "ViewController.h"
#import "SHAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btn1Action:(id)sender {
    
    SHAlertView *ale = [[SHAlertView alloc]initWithTitle:@"标题" message:@"内容" cancelTitle:@"取消" sureTitle:@"确认" cancelAction:nil sureAction:^{
        NSLog(@"确认");
    }];
    [ale show];
}

- (IBAction)btn2Action:(id)sender {
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 4;
    style.alignment = NSTextAlignmentCenter;

    NSDictionary *config = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                             NSForegroundColorAttributeName:[UIColor lightGrayColor],
                             NSParagraphStyleAttributeName:style};
    NSAttributedString *messageAtt = [[NSAttributedString alloc] initWithString:@"0987654321" attributes:config];

    SHClickTextModel *model = [[SHClickTextModel alloc]init];
    model.parameter = @"参数1";
    model.range = NSMakeRange(1, 4);

    SHAlertView *ale = [[SHAlertView alloc]initWithTitle:@"标题" messageAtt:messageAtt parameArr:@[model] cancelTitle:@"取消" sureTitle:@"确定" cancelAction:nil sureAction:nil textAction:^(NSString *parameter) {
        NSLog(@"%@",parameter);
    }];
    [ale show];
}

- (IBAction)btn3Action:(id)sender {
    
    SHAlertView *ale = [[SHAlertView alloc]initWithImage:[UIImage imageNamed:@"help_thank_note_inset"] cancelTitle:@"取消" sureTitle:@"确认" cancelAction:nil sureAction:^{
        NSLog(@"确认");
    }];
    [ale show];
}

- (IBAction)btn4Action:(id)sender {
    
    SHAlertView *ale = [[SHAlertView alloc]initWithIcon:[UIImage imageNamed:@"help_thank_note_inset"] message:@"内容" cancelTitle:@"取消" sureTitle:@"确认" cancelAction:nil sureAction:^{
        NSLog(@"确认");
    }];
    [ale show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
