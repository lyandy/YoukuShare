//
//  AndyCommon.h
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#define YoukuAppKey @"63365abff4b056eb"
#define YoukuAppSecret @"f7e2b2317177fbabbf3fcb34fd2ef7ea"
#define YoukuRedirectURL @"https://client.example.com/cb"

#define YoukuLoginURL [NSString stringWithFormat:@"https://openapi.youku.com/v2/oauth2/authorize?client_id=%@&response_type=code&state=xyz&redirect_uri=%@",YoukuAppKey, YoukuRedirectURL]

#ifdef __OBJC__

#import "TokenConsts.h"

#endif

