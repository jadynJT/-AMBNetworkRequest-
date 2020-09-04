//
//  AMBHttpRequestApi.m
//  HttpRequestTest
//
//  Created by mahailin on 2018/5/12.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import "AMBHttpRequestApi.h"
#import "AMBBLController.h"
#import "LoginModel.h"

@implementation AMBHttpRequestApi

#pragma mark -
#pragma mark ==== 外部使用方法 ====
#pragma mark -

/**
 *  创建单例AMBHttpRequestApi
 *
 *  @return 返回AMBHttpRequestApi实例
 */
+ (instancetype)sharedRequestApi
{
    static id requestApi;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        requestApi = [[self alloc] init];
    });
    
    return requestApi;
}

/**
 处理单个接口请求结果(比如token失效、token过期等)，单个接口请求成功的回调里都必须调用该方法
 
 @param blController 单个接口实例
 @param successBlock 单个接口请求成功回调
 @param faillureBlock 单个接口请求失败回调
 */
- (void)handleRequestResult:(AMBBaseBLController *)blController success:(AMBRequestCompletionBlock)successBlock failure:(AMBRequestCompletionBlock)faillureBlock
{
    AMBBLController *tempBLController = (AMBBLController *)blController;
    
    void(^getDataAgain)(void) = ^{
        
        AMBBLController *getDataAgain = [blController copy];
        [getDataAgain startWithCompletionBlockWithSuccess:successBlock failure:faillureBlock];
    };
    
    void(^requestFailureBlock)(AMBBaseBLController *) = ^(AMBBaseBLController *blController){
        
        if (faillureBlock)
        {
            faillureBlock(blController);
        }
    };
    
    switch (tempBLController.responseResult.code)
    {
        case kAMBRequestSuccess://接口请求成功
        {
            if (successBlock)
            {
                successBlock(blController);
            }
        }
            break;
            
        case kAMBRequestTokenInvaid://token失效处理
        {
            [self reGetTokenSuccess:^(AMBBaseBLController *blController) {
                
                getDataAgain();
            } failure:^(AMBBaseBLController *blController) {
                
                requestFailureBlock(blController);
            }];
        }
            break;
            
        case kAMBRequestTokenExpire://token过期处理
        {
            [self reLoginSuccess:^(AMBBaseBLController *blController) {
                
                getDataAgain();
            } failure:^(AMBBaseBLController *blController) {
                
                requestFailureBlock(blController);
            }];
        }
            break;
            
        default:
            break;
    }
}

/**
 处理批量接口请求结果(比如token失效、token过期等)，批量接口请求成功的回调里都必须调用该方法
 
 @param batchBLController 批量接口实例
 @param successBlock 批量接口请求成功回调
 @param faillureBlock 批量接口请求失败回调
 */
- (void)handleBatchRequestResult:(AMBBatchBLController *)batchBLController success:(AMBRequestBatchCompletionBlock)successBlock failure:(AMBRequestBatchCompletionBlock)faillureBlock
{
    AMBBLController *tempBLController;
    
    for (AMBBLController *temp in batchBLController.requestArray)
    {
        if (temp.responseResult.code != kAMBRequestSuccess)
        {
            tempBLController = temp;
            break;
        }
    }
    
    if (!tempBLController)//接口请求成功
    {
        if (successBlock)
        {
            successBlock(batchBLController, nil);
        }
    }
    else
    {
        void(^getDataAgain)(void) = ^{
            
            AMBBatchBLController *getDataAgain = [batchBLController copy];
            [getDataAgain startWithCompletionBlockWithSuccess:successBlock failure:faillureBlock];
        };
        
        void(^requestFailureBlock)(AMBBaseBLController *) = ^(AMBBaseBLController *blController){
            
            if (faillureBlock)
            {
                faillureBlock(batchBLController, blController);
            }
        };
        
        switch (tempBLController.responseResult.code)
        {
            case kAMBRequestTokenInvaid://token失效处理
            {
                [self reGetTokenSuccess:^(AMBBaseBLController *blController) {
                    
                    getDataAgain();
                } failure:^(AMBBaseBLController *blController) {
                    
                    requestFailureBlock(blController);
                }];
            }
                break;
                
            case kAMBRequestTokenExpire://token过期处理
            {
                [self reLoginSuccess:^(AMBBaseBLController *blController) {
                    
                    getDataAgain();
                } failure:^(AMBBaseBLController *blController) {
                    
                    requestFailureBlock(blController);
                }];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark ==== 内部使用方法 ====
#pragma mark -

/**
 重新获取token方法
 
 @param successBlock 获取token成功后的回调
 @param faillureBlock 获取token失败后的回调
 */
- (void)reGetTokenSuccess:(AMBRequestCompletionBlock)successBlock failure:(AMBRequestCompletionBlock)faillureBlock
{
    LoginParam *param = [[LoginParam alloc] init];
    param.phone = @"13623000023";
    param.password = @"111111";

    AMBBLController *blController = [[AMBBLController alloc] initWithParam:param];
    blController.path = @"auth/login";

    [blController startWithCompletionBlockWithSuccess:^(AMBBaseBLController *controller) {

        if (successBlock)
        {
            successBlock(blController);
        }
    } failure:^(AMBBaseBLController *controller) {

        if (faillureBlock)
        {
            faillureBlock(blController);
        }
    }];
}

/**
 重新登录方法
 
 @param successBlock 登录成功后的回调
 @param faillureBlock 登录失败后的回调
 */
- (void)reLoginSuccess:(AMBRequestCompletionBlock)successBlock failure:(AMBRequestCompletionBlock)faillureBlock
{
//    LoginParam *param = [[LoginParam alloc] init];
//    param.phone = @"13623000023";
//    param.password = @"111111";
//
//    AMBBLController *blController = [[AMBBLController alloc] initWithParam:param];
//    blController.path = @"auth/login";
//
//    [blController startWithCompletionBlockWithSuccess:^(AMBBaseBLController *controller) {
//
//        if (successBlock)
//        {
//            successBlock(blController);
//        }
//    } failure:^(AMBBaseBLController *controller) {
//
//        if (faillureBlock)
//        {
//            faillureBlock(blController);
//        }
//    }];
}

@end
