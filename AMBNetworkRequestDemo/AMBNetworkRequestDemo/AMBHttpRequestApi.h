//
//  AMBHttpRequestApi.h
//  HttpRequestTest
//
//  Created by mahailin on 2018/5/12.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMBBaseBLController.h"
#import "AMBBatchBLController.h"

/**
 该类为网络请求管理类基类，各个模块的管理类都需继承自该类。该类里的方法需由各个项目根据各自的情况自行定制(比如重新登录、重新获取token等等)
 */
@interface AMBHttpRequestApi : NSObject

/**
 *  创建单例
 *
 *  @return 返回所创建的实例
 */
+ (instancetype)sharedRequestApi;

/**
 处理单个接口请求结果(比如token失效、token过期等)，单个接口请求成功的回调里都必须调用该方法
 
 @param blController 单个接口实例
 @param successBlock 单个接口请求成功回调
 @param faillureBlock 单个接口请求失败回调
 */
- (void)handleRequestResult:(AMBBaseBLController *)blController success:(AMBRequestCompletionBlock)successBlock failure:(AMBRequestCompletionBlock)faillureBlock;

/**
 处理批量接口请求结果(比如token失效、token过期等)，批量接口请求成功的回调里都必须调用该方法
 
 @param batchBLController 批量接口实例
 @param successBlock 批量接口请求成功回调
 @param faillureBlock 批量接口请求失败回调
 */
- (void)handleBatchRequestResult:(AMBBatchBLController *)batchBLController success:(AMBRequestBatchCompletionBlock)successBlock failure:(AMBRequestBatchCompletionBlock)faillureBlock;

@end
