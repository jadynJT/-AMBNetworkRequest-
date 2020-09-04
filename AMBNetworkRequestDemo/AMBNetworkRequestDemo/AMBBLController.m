//
//  AMBBLController.m
//  HttpRequestTest
//
//  Created by   马海林 on 2018/4/29.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import "AMBBLController.h"
#import "AMBError.h"
#import "YYModel.h"
#import "Json+AMBSerializing.h"

@interface AMBBLController ()<AMBBaseBLControllerDelegate>

@property (nonatomic, strong) AMBJsonResult *responseResult;

@end

@implementation AMBBLController

#pragma mark -
#pragma mark ==== 系统方法 ====
#pragma mark -

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.delegate = self;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    AMBBLController *blController = [super copyWithZone:zone];
    return blController;
}

#pragma mark -
#pragma mark ==== 外部使用方法 ====
#pragma mark -

/**
 解析成实体类型数据，默认返回YES
 
 @param responseObject 接口请求返回的数据(AMBResponseSerializerTypeHTTP样式时为json字符串，AMBResponseSerializerTypeJSON样式时为json object，AMBResponseSerializerTypeXMLParser样式时为NSXMLParser类型数据)
 @return 解析成实体类型数据，成功为YES，失败为NO
 */
- (BOOL)parseResponseData:(id)responseObject
{
    BOOL isParseSuccess = NO;
    NSString *dataError = @"数据格式有误";
    responseObject = [responseObject isKindOfClass:[NSString class]] ? [responseObject amb_JSONObject] : responseObject;
    
    if ([responseObject isKindOfClass:[NSDictionary class]])//获取到数据，且解析后得到的结果是我们想要的
    {
        self.responseResult = [AMBJsonResult yy_modelWithDictionary:responseObject];
        
        if (self.responseResult.code == kAMBRequestSuccess)//获取到数据，且code代表成功
        {
            isParseSuccess = YES;
            
            if (self.dataModelClass)
            {
                self.responseResult.data = [self.responseResult.data isKindOfClass:[NSString class]] ? [self.responseResult.data amb_JSONObject] : self.responseResult.data;
                
                if ([self.responseResult.data isKindOfClass:[NSDictionary class]])
                {
                    self.responseResult.data = [self.dataModelClass yy_modelWithDictionary:self.responseResult.data];
                }
                else if ([self.responseResult.data isKindOfClass:[NSArray class]])
                {
                    self.responseResult.data = [NSArray yy_modelArrayWithClass:self.dataModelClass json:(NSArray *)self.responseResult.data];
                }
            }
        }
        else if (self.responseResult.code == kAMBRequestTokenInvaid
                 || self.responseResult.code == kAMBRequestTokenExpire)
        {
            isParseSuccess = YES;
        }
        else//获取到数据，但code代表失败
        {
            NSString *msg = self.responseResult.msg.description.length > 0 ? self.responseResult.msg.description : @"";
            self.error = [AMBError errorWithType:AMBErrorTypeCodeError errorMessage:msg];
        }
    }
    else//获取到数据，但是该数据格式并不是我们想要的格式
    {
        self.error = [AMBError errorWithType:AMBErrorTypeReturnDataStyleError errorMessage:dataError];
    }
    
    return isParseSuccess;
}

#pragma mark -
#pragma mark ==== AMBBaseBLControllerDelegate ====
#pragma mark -

- (void)blControllerFailed:(AMBBaseBLController *)blController
{
//    if (self.error.code == kCFURLErrorNotConnectedToInternet)//无网络
//    {
//        self.error = [AMBError errorWithType:AMBErrorTypeNetworkUnreachable errorMessage:@"联网失败，请检查手机网络状态"];
//    }
    
#warning 此处用于定义各种网络请求失败的描述，比如404，500等
    if (!self.error)
    {
        self.error = [AMBError errorWithType:AMBErrorTypeNetworkUnreachable errorMessage:@"联网失败，请检查手机网络状态"];
    }
}

@end
