//
//  AMBJsonResult.h
//  XHJ
//
//  Created by mhl on 16/5/27.
//  Copyright © 2016年 mhl. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络请求成功
 */
#define kAMBRequestSuccess 0

/**
 网络请求token失效
 */
#define kAMBRequestTokenInvaid 106

/**
 网络请求token过期
 */
#define kAMBRequestTokenExpire 400

/**
 Json数据根实体
 */
@interface AMBJsonResult : NSObject

/**
 错误码
 */
@property (nonatomic, assign) NSInteger code;

/**
 出现错误时的提示信息
 */
@property (nonatomic, copy) NSString *msg;

/**
 业务返回结果
 */
@property (nonatomic, strong) id data;

@end
