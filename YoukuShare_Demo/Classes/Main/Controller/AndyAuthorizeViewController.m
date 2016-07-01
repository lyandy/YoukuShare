//
//  AndyAuthorizeViewController.m
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyAuthorizeViewController.h"
#import "AndyAccessTokenModel.h"
#import "AndyAccessTokenInfoTool.h"
#import "AndyUploadViewController.h"


@interface AndyAuthorizeViewController ()<UIWebViewDelegate>

@end

@implementation AndyAuthorizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:YoukuLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD showError:@"发生错误"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
    NSArray *strArr = [urlStr componentsSeparatedByString:@"&"];
    
    NSString *firstStr = (NSString *)[strArr firstObject];
    
    NSRange range = [firstStr rangeOfString:@"code="];
    
    if (range.length != 0)
    {
        NSUInteger loc = range.location + range.length;
        
        NSString *code = [firstStr substringFromIndex:loc];

        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"client_id"] = YoukuAppKey;
    params[@"client_secret"] = YoukuAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = YoukuRedirectURL;
    
    [AndyHttpTool postWithURL:@"https://openapi.youku.com/v2/oauth2/token" params:params success:^(id json) {
        
        AndyAccessTokenModel *accesssTokenModel = [AndyAccessTokenModel accessTokenModelWithDict:json];
        
        [AndyAccessTokenInfoTool saveAccessTokenInfo:accesssTokenModel];
        
        //切换到上传视频控制器
        [UIApplication sharedApplication].keyWindow.rootViewController = [[AndyUploadViewController alloc] init];

        
        [MBProgressHUD hideHUDForView:self.view];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"授权失败，请重试"];
        
        //TO-DO:这里根据需要可以添加一个 “重试” 按钮。点击后，再次访问 YoukuLoginURL 链接即可
    }];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
