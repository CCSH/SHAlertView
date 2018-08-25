//
//  SHAlertView.h
//  SHAlertViewExmpale
//
//  Created by CSH on 2018/8/24.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHClickTextView.h>

typedef void(^AlertSureAction) (void);
typedef void(^AlertCancelAction) (void);
typedef void(^AlertTextAction) (NSString *parameter);

/**
 悬浮框
 */
@interface SHAlertView : UIView

/**
 初始化

 @param title 标题 (可以是 NSString、NSAttributedString)
 @param message 内容 (可以是 NSString、NSAttributedString)
 @param cancelTitle 取消名称
 @param sureTitle 确认名称
 @param cancelAction 取消回调
 @param sureAction 确认回调
 */
- (instancetype)initWithTitle:(id)title
                      message:(id)message
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction;

/**
 初始化(富文本)

 @param title 标题 (可以是 NSString、NSAttributedString)
 @param messageAtt 内容(富文本)
 @param parameArr 属性集合
 @param cancelTitle 取消名称
 @param sureTitle 确认名称
 @param cancelAction 取消回调
 @param sureAction 确认回调
 @param textAction 文本回调
 */
- (instancetype)initWithTitle:(id)title
                   messageAtt:(NSAttributedString *)messageAtt
                    parameArr:(NSArray <SHClickTextModel *>*)parameArr
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction
                   textAction:(AlertTextAction)textAction;


/**
 初始化(插画)

 @param image 插画
 @param cancelTitle 取消名称
 @param sureTitle 确认名称
 @param cancelAction 取消回调
 @param sureAction 确认回调
 */
- (instancetype)initWithImage:(UIImage *)image
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction;


/**
 初始化(图标)

 @param icon 图标
 @param message 内容(可以是 NSString、NSAttributedString)
 @param cancelTitle 取消名称
 @param sureTitle 确认名称
 @param cancelAction 取消回调
 @param sureAction 确认回调
 */
- (instancetype)initWithIcon:(UIImage *)icon
                      message:(id)message
                  cancelTitle:(NSString *)cancelTitle
                    sureTitle:(NSString *)sureTitle
                 cancelAction:(AlertCancelAction)cancelAction
                   sureAction:(AlertSureAction)sureAction;

/**
 显示在window上
 */
- (void)show;

/**
 显示在指定的View上

 @param inView 指定View
 */
- (void)showInView:(UIView *)inView;

@end
