//
//  ViewController.m
//  AMBNetworkRequestDemo
//
//  Created by   马海林 on 2018/6/13.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import "ViewController.h"
#import "UploadFileParam.h"
#import "LoginModel.h"
#import "AMBBLController.h"
#import "LoginModuleHttpRequestApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LoginParam *param = [[LoginParam alloc] init];
    param.phone = @"13623000023";
    param.password = @"111111";

    [[LoginModuleHttpRequestApi sharedRequestApi] getLoginData:param success:^(AMBBaseBLController *blController) {

        NSLog(@"请求成功");
        AMBBLController *controller = (AMBBLController *)blController;
        LoginModel *model = (LoginModel *)controller.responseResult.data;
        NSLog(@"isCheck = %i", model.isCheck);
    } failure:^(AMBBaseBLController *blController) {

        NSLog(@"请求失败");
    }];
    
//    UploadFileParam *fileParam = [UploadFileParam new];
//    fileParam.dir = @"babyAvatar";
//    fileParam.token = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMzYyMzAwMDAyMyIsImlzcyI6Imh0dHBzOi8vdGVzdGFwaS54aHVpamlhLmNvbS9hcGkvdjEvYXV0aC9sb2dpbiIsImlhdCI6MTUyNTMwODg5NiwiZXhwIjoxNTI1OTEzNjk2LCJuYmYiOjE1MjUzMDg4OTYsImp0aSI6IkhzUnVnaGpIcml6b3ZmUFIifQ.VYU-BybpHUsmv_6Ce9I7o9LbMVeehp2QrVc4iRV297I";
//
//    [[LoginModuleHttpRequestApi sharedRequestApi] testBatchUploadFileData:fileParam success:^(AMBBatchBLController *batchBLController, AMBBaseBLController *failedBLController) {
//
//        NSLog(@"上传文件成功");
//    } failure:^(AMBBatchBLController *batchBLController, AMBBaseBLController *failedBLController) {
//
//        NSLog(@"上传文件失败");
//    }];
}

@end
