//
//  LoginModuleHttpRequestApi.h
//  HttpRequestTest
//
//  Created by   马海林 on 2018/5/2.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMBHttpRequestApi.h"

/**
 登录模块接口请求管理类
 */
@interface LoginModuleHttpRequestApi : AMBHttpRequestApi

- (void)getLoginData:(NSObject *)param success:(AMBRequestCompletionBlock)successBlock failure:(AMBRequestCompletionBlock)faillureBlock;

- (void)testBatchUploadFileData:(NSObject *)param success:(AMBRequestBatchCompletionBlock)successBlock failure:(AMBRequestBatchCompletionBlock)faillureBlock;

@end
