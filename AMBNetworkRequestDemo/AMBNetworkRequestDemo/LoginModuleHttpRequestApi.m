//
//  LoginModuleHttpRequestApi.m
//  HttpRequestTest
//
//  Created by   马海林 on 2018/5/2.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModuleHttpRequestApi.h"
#import "AMBBLController.h"
#import "LoginModel.h"

@implementation LoginModuleHttpRequestApi

- (void)getLoginData:(NSObject *)param success:(AMBRequestCompletionBlock)successBlock failure:(AMBRequestCompletionBlock)faillureBlock
{
    AMBBLController *blController = [[AMBBLController alloc] initWithParam:param];
    blController.path = @"auth/login";
    blController.dataModelClass = [LoginModel class];
    
    [blController startWithCompletionBlockWithSuccess:^(AMBBaseBLController *blController) {
        
        ((AMBBLController *)blController).responseResult.code = kAMBRequestTokenInvaid;
        [self handleRequestResult:blController success:successBlock failure:faillureBlock];
    } failure:^(AMBBaseBLController *blController) {
        
        if (faillureBlock)
        {
            faillureBlock(blController);
        }
    }];
}

- (void)testBatchUploadFileData:(NSObject *)param success:(AMBRequestBatchCompletionBlock)successBlock failure:(AMBRequestBatchCompletionBlock)faillureBlock
{
    UIImage *image = [UIImage imageNamed:@"Icon"];
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    NSMutableArray *requestArray = [NSMutableArray array];
    
    for (int i = 0; i < 1; i++)
    {
        AMBBLController *uploadBLController = [[AMBBLController alloc] initWithParam:param];
        uploadBLController.requestMethod = AMBRequestMothodPOST;
        uploadBLController.path = @"file/upload";
        
        uploadBLController.constructingBodyBlock = ^(id<AMBMultipartFormData> formData) {
            
            [formData appendPartWithFileData:data name:@"file" fileName:@"file" mimeType:@"image/jpeg"];
        };
        
        [requestArray addObject:uploadBLController];
    }
    
    AMBBatchBLController *blController = [[AMBBatchBLController alloc] initWithRequestArray:requestArray];
    
    [blController startWithCompletionBlockWithSuccess:^(AMBBatchBLController *batchBLController, AMBBaseBLController *failedBLController) {
        
        [blController.requestArray enumerateObjectsUsingBlock:^(AMBBaseBLController *obj, NSUInteger idx, BOOL *stop) {

            AMBBLController *temp = (AMBBLController *)obj;
            temp.responseResult.code = kAMBRequestTokenInvaid;
        }];
        
        [self handleBatchRequestResult:blController success:successBlock failure:faillureBlock];
    } failure:^(AMBBatchBLController *batchBLController, AMBBaseBLController *failedBLController) {
        
        if (faillureBlock)
        {
            faillureBlock(batchBLController, failedBLController);
        }
    }];
}

@end
