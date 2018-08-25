//
//  SHAlertView.m
//  SHAlertViewExmpale
//
//  Created by CSH on 2018/8/24.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import "SHAlertView.h"

#define kSHWidth  [UIScreen mainScreen].bounds.size.width
#define kSHHeight  [UIScreen mainScreen].bounds.size.height
//弹框宽
#define kAlertContentWidth MIN(kSHWidth*0.75, 300)

@interface SHAlertView ()

//主体
@property (nonatomic, strong) UIView *mainView;
//标题
@property (nonatomic, strong) UILabel *titleLab;
//内容
@property (nonatomic, strong) SHClickTextView *messageText;
//取消
@property (nonatomic, strong) UIButton *cancelBtn;
//确认
@property (nonatomic, strong) UIButton *surelBtn;

//回调
//取消回调
@property (nonatomic, copy) AlertCancelAction cancelAction;
//确认回调
@property (nonatomic, copy) AlertSureAction sureAction;
//文本回调
@property (nonatomic, copy) AlertTextAction textAction;

@end;

@implementation SHAlertView

#pragma mark - 懒加载
//主体
- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _mainView.layer.cornerRadius = 4;
        _mainView.userInteractionEnabled = YES;
        [self addSubview:_mainView];
    }
    return _mainView;
}

//标题
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(15, 0, kAlertContentWidth - 2*15, 0);
        _titleLab.font = [UIFont systemFontOfSize:20];
        _titleLab.numberOfLines = 0;
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.mainView addSubview:_titleLab];
    }
    return _titleLab;
}

//内容
- (SHClickTextView *)messageText{
    if (!_messageText) {
        _messageText = [[SHClickTextView alloc]init];
        _messageText.userInteractionEnabled = YES;
        _messageText.frame = CGRectMake(15, 0, kAlertContentWidth - 2*15, 0);
        _messageText.font = [UIFont systemFontOfSize:16];
        _messageText.textColor = [UIColor lightGrayColor];
        [self.mainView addSubview:_messageText];
    }
    return _messageText;
}

//取消
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 0, kAlertContentWidth, 48);
        _cancelBtn.tag = 1;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn setTitleColor:[UIColor darkGrayColor] forState:0];
        [_cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

//确认
- (UIButton *)surelBtn{
    if (!_surelBtn) {
        _surelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _surelBtn.frame = CGRectMake(0, 0, kAlertContentWidth, 48);
        _surelBtn.tag = 2;
        _surelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_surelBtn setTitleColor:[UIColor orangeColor] forState:0];
        [_surelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:_surelBtn];
    }
    return _surelBtn;
}

#pragma mark - 点击方法
- (void)btnAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1://取消
        {
            if (self.cancelAction) {
                self.cancelAction();
            }
        }
            break;
        case 2://确认
        {
            if (self.sureAction) {
                self.sureAction();
            }
        }
            break;
        default:
            break;
    }
    
    [self hideView];
}

#pragma mark - 公开方法
#pragma mark 初始化
- (instancetype)initWithTitle:(id)title
                      message:(id)message
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, kSHWidth, kSHWidth);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        //标题不存在，内容存在
        if (![title length] && [message length]) {
            title = message;
            message = nil;
        }
        
        self.cancelAction = cancelAction;
        self.sureAction = sureAction;

        CGFloat view_y = 15;
        
        //标题
        if ([title length]) {
            
            NSAttributedString *titleAtt = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",title]];
            
            if ([title isKindOfClass:[NSString class]]) {//字符串
                
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                style.lineSpacing = 4;
                style.alignment = NSTextAlignmentCenter;
                
                NSDictionary *config = @{NSFontAttributeName:self.titleLab.font,
                                         NSForegroundColorAttributeName:self.titleLab.textColor,
                                         NSParagraphStyleAttributeName:style};
                titleAtt = [[NSAttributedString alloc] initWithString:title attributes:config];
                
            }else if ([title isKindOfClass:[NSAttributedString class]]){//富文本
                
                titleAtt = title;
            }
            
            self.titleLab.attributedText = titleAtt;
            
            CGSize size = [titleAtt boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.titleLab.frame), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            CGRect frame = self.titleLab.frame;
            frame.size.height = ceil(size.height);
            frame.origin.y = view_y;
            self.titleLab.frame = frame;
            
            view_y = CGRectGetMaxY(self.titleLab.frame) + 15;
        }
        
        //内容
        if ([message length]) {
            
            NSAttributedString *messageAtt = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",message]];
            
            if ([message isKindOfClass:[NSString class]]) {//字符串
                
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                style.lineSpacing = 4;
                style.alignment = NSTextAlignmentCenter;
                
                NSDictionary *config = @{NSFontAttributeName:self.messageText.font,
                                         NSForegroundColorAttributeName:self.messageText.textColor,
                                         NSParagraphStyleAttributeName:style};
                messageAtt = [[NSAttributedString alloc] initWithString:message attributes:config];
                
            }else if ([message isKindOfClass:[NSAttributedString class]]){//富文本
                
                messageAtt = messageAtt;
            }

            self.messageText.attributedText = messageAtt;
            
            CGSize size = [messageAtt boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.messageText.frame), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            CGRect frame = self.messageText.frame;
            frame.size.height = ceil(size.height);
            frame.origin.y = view_y;
            self.messageText.frame = frame;
            
            view_y = CGRectGetMaxY(self.messageText.frame) + 15;
        }
        
        //都不存在
        if (![title length]) {
            
            view_y = 0;
        }else{
            
            //分割线
            CALayer *line = [CALayer layer];
            line.frame = CGRectMake(0, view_y, kAlertContentWidth,0.5);
            line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:line];
            
            view_y += CGRectGetHeight(line.frame) + 1;
        }
        
        //取消
        if (cancelTitle.length) {
            [self.cancelBtn setTitle:cancelTitle forState:0];
            
            CGRect frame = self.cancelBtn.frame;
            frame.origin.y = view_y;
            self.cancelBtn.frame = frame;
        }
        
        //确认
        if (sureTitle.length) {
            [self.surelBtn setTitle:sureTitle forState:0];
            CGRect frame = self.surelBtn.frame;
            frame.origin.y = view_y;
            self.surelBtn.frame = frame;
        }
        
        //同时存在
        if (cancelTitle.length && sureTitle.length) {
            //分割线
            CALayer *verLine = [CALayer layer];
            verLine.frame = CGRectMake((kAlertContentWidth - 0.5)/2, view_y, 0.5, 48);
            verLine.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:verLine];
            
            CGRect frame = self.cancelBtn.frame;
            frame.size.width = kAlertContentWidth/2;
            
            self.cancelBtn.frame = frame;
            frame.origin.x = kAlertContentWidth/2;
            self.surelBtn.frame = frame;
        }
        
        if (cancelTitle.length || sureTitle.length) {
            view_y += 48;
        }
        
        CGRect frame = CGRectMake(0, 0, kAlertContentWidth, view_y);
        self.mainView.frame = frame;
        self.mainView.center = self.center;
    }
    return self;
}

#pragma mark 初始化(富文本)
- (instancetype)initWithTitle:(id)title
                   messageAtt:(NSAttributedString *)messageAtt
                    parameArr:(NSArray <SHClickTextModel *>*)parameArr
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction
                   textAction:(AlertTextAction)textAction{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, kSHWidth, kSHWidth);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        self.cancelAction = cancelAction;
        self.sureAction = sureAction;
        self.textAction = textAction;
        
        CGFloat view_y = 15;
        
        //标题
        if ([title length]) {
            
            NSAttributedString *titleAtt = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",title]];
            
            if ([title isKindOfClass:[NSString class]]) {//字符串
                
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                style.lineSpacing = 4;
                style.alignment = NSTextAlignmentCenter;
                
                NSDictionary *config = @{NSFontAttributeName:self.titleLab.font,
                                         NSForegroundColorAttributeName:self.titleLab.textColor,
                                         NSParagraphStyleAttributeName:style};
                titleAtt = [[NSAttributedString alloc] initWithString:title attributes:config];
                
            }else if ([titleAtt isKindOfClass:[NSAttributedString class]]){//富文本
                
                titleAtt = title;
            }
            
            self.titleLab.attributedText = titleAtt;
            
            CGSize size = [messageAtt boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.titleLab.frame), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            CGRect frame = self.titleLab.frame;
            frame.size.height = ceil(size.height);
            frame.origin.y = view_y;
            self.titleLab.frame = frame;
            
            view_y = CGRectGetMaxY(self.titleLab.frame) + 15;
        }
        
        //内容
        if (messageAtt.length) {
            
            self.messageText.attributedText = messageAtt;
            self.messageText.linkArr = parameArr;
            __weak typeof(self) weakSelf = self;
            self.messageText.clickTextBlock = ^(SHClickTextModel *model, SHClickTextView *textView) {
                if (weakSelf.textAction) {
                    weakSelf.textAction(model.parameter);
                }
            };
            
            CGSize size = [messageAtt boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.messageText.frame), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            CGRect frame = self.messageText.frame;
            frame.size.height = ceil(size.height);
            frame.origin.y = view_y;
            self.messageText.frame = frame;
            
            view_y = CGRectGetMaxY(self.messageText.frame) + 15;
        }
        
        //都不存在
        if (!([title length] || [messageAtt length])) {
            
            view_y = 0;
        }else{
            
            //分割线
            CALayer *line = [CALayer layer];
            line.frame = CGRectMake(0, view_y, kAlertContentWidth,0.5);
            line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:line];
            
            view_y += CGRectGetHeight(line.frame) + 1;
        }
        
        //取消
        if (cancelTitle.length) {
            [self.cancelBtn setTitle:cancelTitle forState:0];
            
            CGRect frame = self.cancelBtn.frame;
            frame.origin.y = view_y;
            self.cancelBtn.frame = frame;
        }
        
        //确认
        if (sureTitle.length) {
            [self.surelBtn setTitle:sureTitle forState:0];
            CGRect frame = self.surelBtn.frame;
            frame.origin.y = view_y;
            self.surelBtn.frame = frame;
        }
        
        //同时存在
        if (cancelTitle.length && sureTitle.length) {
            //分割线
            CALayer *verLine = [CALayer layer];
            verLine.frame = CGRectMake((kAlertContentWidth - 0.5)/2, view_y, 0.5, 48);
            verLine.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:verLine];
            
            CGRect frame = self.cancelBtn.frame;
            frame.size.width = kAlertContentWidth/2;
            
            self.cancelBtn.frame = frame;
            frame.origin.x = kAlertContentWidth/2;
            self.surelBtn.frame = frame;
        }
        
        if (cancelTitle.length || sureTitle.length) {
            view_y += 48;
        }
        
        CGRect frame = CGRectMake(0, 0, kAlertContentWidth, view_y);
        self.mainView.frame = frame;
        self.mainView.center = self.center;
    }
    return self;
    
}


#pragma mark 初始化(插画)
- (instancetype)initWithImage:(UIImage *)image
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, kSHWidth, kSHWidth);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        self.cancelAction = cancelAction;
        self.sureAction = sureAction;
        
        CGFloat view_y = 15;
        
        //内容
        if (image) {
            
            CGFloat image_h = (image.size.height*kAlertContentWidth)/image.size.width;
            
            //添加图片
            NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
            // 标记图片
            attchImage.image = image;
            // 设置图片大小
            attchImage.bounds = CGRectMake(0, 0, kAlertContentWidth, image_h);
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.alignment = NSTextAlignmentCenter;
            
            NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] init];
            [messageAtt appendAttributedString:[NSAttributedString attributedStringWithAttachment:attchImage]];
            [messageAtt addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, messageAtt.length)];
            
            self.messageText.userInteractionEnabled = NO;
            self.messageText.attributedText = messageAtt;
            
            self.messageText.frame = CGRectMake(0, 0, kAlertContentWidth, image_h);
        
            view_y = CGRectGetMaxY(self.messageText.frame);
        }
        
        //都不存在
        if (!image) {
            
            view_y = 0;
        }else{
            
            //分割线
            CALayer *line = [CALayer layer];
            line.frame = CGRectMake(0, view_y, kAlertContentWidth,0.5);
            line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:line];
            
            view_y += CGRectGetHeight(line.frame) + 1;
        }
        
        //取消
        if (cancelTitle.length) {
            [self.cancelBtn setTitle:cancelTitle forState:0];
            
            CGRect frame = self.cancelBtn.frame;
            frame.origin.y = view_y;
            self.cancelBtn.frame = frame;
        }
        
        //确认
        if (sureTitle.length) {
            [self.surelBtn setTitle:sureTitle forState:0];
            CGRect frame = self.surelBtn.frame;
            frame.origin.y = view_y;
            self.surelBtn.frame = frame;
        }
        
        //同时存在
        if (cancelTitle.length && sureTitle.length) {
            //分割线
            CALayer *verLine = [CALayer layer];
            verLine.frame = CGRectMake((kAlertContentWidth - 0.5)/2, view_y, 0.5, 48);
            verLine.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:verLine];
            
            CGRect frame = self.cancelBtn.frame;
            frame.size.width = kAlertContentWidth/2;
            
            self.cancelBtn.frame = frame;
            frame.origin.x = kAlertContentWidth/2;
            self.surelBtn.frame = frame;
        }
        
        if (cancelTitle.length || sureTitle.length) {
            view_y += 48;
        }
        
        CGRect frame = CGRectMake(0, 0, kAlertContentWidth, view_y);
        self.mainView.frame = frame;
        self.mainView.center = self.center;
    }
    return self;
}


#pragma mark 初始化(图标)
- (instancetype)initWithIcon:(UIImage *)icon
                      message:(id)message
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, kSHWidth, kSHWidth);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        self.cancelAction = cancelAction;
        self.sureAction = sureAction;
        
        CGFloat view_y = 15;
        
        //图标
        if (icon) {
            //icon size
            CGSize size = CGSizeMake(kAlertContentWidth/3, kAlertContentWidth/3*icon.size.height/icon.size.width);
            //添加图片
            NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
            // 标记图片
            attchImage.image = icon;
            // 设置图片大小
            attchImage.bounds = CGRectMake(0, 0, size.width, size.height);
            
            NSMutableAttributedString *iconAtt = [[NSMutableAttributedString alloc] init];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.alignment = NSTextAlignmentCenter;
            [iconAtt appendAttributedString:[NSAttributedString attributedStringWithAttachment:attchImage]];
            [iconAtt addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, iconAtt.length)];

            self.titleLab.userInteractionEnabled = NO;
            self.titleLab.attributedText = iconAtt;
  
            self.titleLab.frame = CGRectMake(0, -size.height/2, kAlertContentWidth, size.height);
            
            view_y = CGRectGetHeight(self.titleLab.frame)/2 + 15;
        }
        
        //内容
        if ([message length]) {
            
            NSAttributedString *messageAtt = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",message]];
            
            if ([message isKindOfClass:[NSString class]]) {//字符串
                
                NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
                style.lineSpacing = 4;
                style.alignment = NSTextAlignmentCenter;
                
                NSDictionary *config = @{NSFontAttributeName:self.messageText.font,
                                         NSForegroundColorAttributeName:self.messageText.textColor,
                                         NSParagraphStyleAttributeName:style};
                messageAtt = [[NSAttributedString alloc] initWithString:message attributes:config];
                
            }else if ([message isKindOfClass:[NSAttributedString class]]){//富文本
                
                messageAtt = messageAtt;
            }
            
            self.messageText.attributedText = messageAtt;
            
            CGSize size = [messageAtt boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.messageText.frame), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            
            CGRect frame = self.messageText.frame;
            frame.size.height = ceil(size.height);
            frame.origin.y = view_y;
            self.messageText.frame = frame;
            
            view_y = CGRectGetMaxY(self.messageText.frame) + 15;
        }
        
        //都不存在
        if (!(icon || [message length])) {
            
            view_y = 0;
        }else{
            
            //分割线
            CALayer *line = [CALayer layer];
            line.frame = CGRectMake(0, view_y, kAlertContentWidth,0.5);
            line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:line];
            
            view_y += CGRectGetHeight(line.frame) + 1;
        }
        
        //取消
        if (cancelTitle.length) {
            [self.cancelBtn setTitle:cancelTitle forState:0];
            
            CGRect frame = self.cancelBtn.frame;
            frame.origin.y = view_y;
            self.cancelBtn.frame = frame;
        }
        
        //确认
        if (sureTitle.length) {
            [self.surelBtn setTitle:sureTitle forState:0];
            CGRect frame = self.surelBtn.frame;
            frame.origin.y = view_y;
            self.surelBtn.frame = frame;
        }
        
        //同时存在
        if (cancelTitle.length && sureTitle.length) {
            //分割线
            CALayer *verLine = [CALayer layer];
            verLine.frame = CGRectMake((kAlertContentWidth - 0.5)/2, view_y, 0.5, 48);
            verLine.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            [self.mainView.layer addSublayer:verLine];
            
            CGRect frame = self.cancelBtn.frame;
            frame.size.width = kAlertContentWidth/2;
            
            self.cancelBtn.frame = frame;
            frame.origin.x = kAlertContentWidth/2;
            self.surelBtn.frame = frame;
        }
        
        if (cancelTitle.length || sureTitle.length) {
            view_y += 48;
        }
        
        CGRect frame = CGRectMake(0, 0, kAlertContentWidth, view_y);
        self.mainView.frame = frame;
        self.mainView.center = self.center;
    }
    return self;

}

#pragma mark 显示在window上
- (void)show{
    [self showInView:[UIApplication sharedApplication].delegate.window];
}


#pragma mark 显示在指定的View上
- (void)showInView:(UIView *)inView{
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth(inView.frame), CGRectGetHeight(inView.frame));
    
    [inView addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
}

#pragma mark 隐藏
- (void)hideView{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
