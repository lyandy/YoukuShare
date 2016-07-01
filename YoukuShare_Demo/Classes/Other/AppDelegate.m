//
//  AppDelegate.m
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AppDelegate.h"
#import "AndyAuthorizeViewController.h"
#import "AndyAccessTokenInfoTool.h"
#import "AndyAccessTokenModel.h"
#import "AndyUploadViewController.h"
#import "YoukuUploader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [self.window makeKeyAndVisible];
    
    [[YoukuUploader sharedInstance] setClientID:YoukuAppKey andClientSecret:YoukuAppSecret];
    
    AndyAccessTokenModel *accessTokenModel = [AndyAccessTokenInfoTool accessTokenInfo];
    //如果为 nil 说明授权过期。 授权过期分为两个情况 1、从未授权  2、 的确是授权过期
    if (accessTokenModel == nil)
    {
        self.window.rootViewController = [[AndyAuthorizeViewController alloc] init];
    }
    else
    {
        [[DictStore sharedDictStore] setOrUpdateValue:accessTokenModel.access_token ForKey:YOUKU_ACCESSTOKEN_KEY];
        
        self.window.rootViewController = [[AndyUploadViewController alloc] init];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
