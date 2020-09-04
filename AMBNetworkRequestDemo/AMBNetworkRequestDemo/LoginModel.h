//
//  LoginModel.h
//  HttpRequestTest
//
//  Created by   马海林 on 2018/5/2.
//  Copyright © 2018年   马海林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginParam : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

@end

@interface LoginModel : NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) BOOL isCheck;

@end
