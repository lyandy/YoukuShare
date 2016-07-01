//
//  AndyAccessTokenInfoTool.h
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AndyAccessTokenModel;

@interface AndyAccessTokenInfoTool : NSObject

+ (void)saveAccessTokenInfo:(AndyAccessTokenModel *)accessTokenModel;

+ (AndyAccessTokenModel *)accessTokenInfo;

@end
