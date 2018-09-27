//
//  SHClickTextModel.h
//  SHClickTextViewExample
//
//  Created by CSH on 2018/8/25.
//  Copyright © 2018年 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 文字局部点击Model
 */
@interface SHClickTextModel : NSObject

//参数
@property (nonatomic, copy) id parameter;
//范围
@property (nonatomic, assign) NSRange range;

@end
