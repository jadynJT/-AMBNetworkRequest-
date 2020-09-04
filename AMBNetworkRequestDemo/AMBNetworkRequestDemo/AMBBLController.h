//
//  AMBBLController.h
//  HttpRequestTest
//
//  Created by   马海林 on 2018/4/29.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import "AMBBaseBLController.h"
#import "AMBJsonResult.h"

@interface AMBBLController : AMBBaseBLController

/**
 解析后的数据实体
 */
@property (nonatomic, strong, readonly) AMBJsonResult *responseResult;

@end
