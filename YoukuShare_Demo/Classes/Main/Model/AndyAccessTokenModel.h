//
//  AndyAccessTokenModel.h
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AndyAccessTokenModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) NSDate *expiresTime;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, copy) NSString *refresh_token;
@property (nonatomic, copy) NSString *token_type;

+ (instancetype)accessTokenModelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
