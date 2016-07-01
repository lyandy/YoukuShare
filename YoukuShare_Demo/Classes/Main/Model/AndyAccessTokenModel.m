//
//  AndyAccessTokenModel.m
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyAccessTokenModel.h"

@implementation AndyAccessTokenModel

+ (instancetype)accessTokenModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.refresh_token = [aDecoder decodeObjectForKey:@"refresh_token"];
        self.token_type = [aDecoder decodeObjectForKey:@"token_type"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.refresh_token forKey:@"refresh_token"];
    [aCoder encodeObject:self.token_type forKey:@"token_type"];
}

@end
