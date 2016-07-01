//
//  AndyAccessTokenInfoTool.m
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyAccessTokenInfoTool.h"
#import "AndyAccessTokenModel.h"

#define YoukuAccessTokenFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YoukuAccessToken.data"]

@implementation AndyAccessTokenInfoTool

+ (void)saveAccessTokenInfo:(AndyAccessTokenModel *)accessTokenModel
{
    NSDate *now = [NSDate date];
    accessTokenModel.expiresTime = [now dateByAddingTimeInterval:accessTokenModel.expires_in];
    
    [[DictStore sharedDictStore] setOrUpdateValue:accessTokenModel.access_token ForKey:YOUKU_ACCESSTOKEN_KEY];
    
    [NSKeyedArchiver archiveRootObject:accessTokenModel toFile:YoukuAccessTokenFile];
}

/**
 *  读取AccessToken文件内的信息，如果返回为nil则为过期
 *
 *  @return AccessToken文件内的信息
 */
+ (AndyAccessTokenModel *)accessTokenInfo
{
    AndyAccessTokenModel *accessTokenModel = [NSKeyedUnarchiver unarchiveObjectWithFile:YoukuAccessTokenFile];
    NSDate *now = [NSDate date];
    if ([now compare:accessTokenModel.expiresTime] == NSOrderedAscending)
    {
        return accessTokenModel;
    }
    else
    {
        return nil;
    }
}

@end
