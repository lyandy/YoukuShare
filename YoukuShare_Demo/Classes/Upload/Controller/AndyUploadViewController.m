//
//  AndyUploadViewController.m
//  YoukuShare_Demo
//
//  Created by 李扬 on 16/5/19.
//  Copyright © 2016年 andyli. All rights reserved.
//

#import "AndyUploadViewController.h"
#import "YoukuUploaderDelegate.h"
#import "YoukuUploader.h"

@interface AndyUploadViewController ()<YoukuUploaderDelegate>

@property (nonatomic, strong) UILabel *progresssLabel;

@property (nonatomic, strong) UIButton *btnUpload;

@end

@implementation AndyUploadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubViews];
    
    [self setupAutoLayout];
}

- (void)setupSubViews
{
    UILabel *progressLabel = [[UILabel alloc] init];
    [progressLabel setTextColor:[UIColor blackColor]];
    [progressLabel setFont:[UIFont systemFontOfSize:20]];
    [progressLabel setText:@"0%"];
    self.progresssLabel = progressLabel;
    [self.view addSubview:self.progresssLabel];
    
    UIButton *btnUpload = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnUpload setTitle:@"开始上传" forState:UIControlStateNormal];
    [btnUpload addTarget:self action:@selector(uploadVideo:) forControlEvents:UIControlEventTouchUpInside];
    self.btnUpload = btnUpload;
    [self.view addSubview:self.btnUpload];
}

- (void)setupAutoLayout
{
    CGFloat margin = 80;
    
    [self.progresssLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view).offset(margin);
    }];
    
    [self.btnUpload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.progresssLabel.centerX);
        make.top.equalTo(self.progresssLabel).offset(margin);
    }];
}

- (void)onStart
{
    AndyLog(@"开始上传...");
}

- (void)onProgressUpdate:(int)progress
{
    self.progresssLabel.text = [NSString stringWithFormat:@"%d%%", progress];
}

- (void)onSuccess:(NSString *)vid
{
    [self.btnUpload setEnabled:YES];
    
    [MBProgressHUD showSuccess:@"上传成功"];
}

- (void)onFailure:(NSDictionary *)response
{
    [MBProgressHUD showError:@"上传失败"];
    
    AndyLog(@"%@", response);
}

- (void)uploadVideo:(UIButton *)btn
{
    NSString *accessToken = (NSString *)[[DictStore sharedDictStore] getValueForKey:YOUKU_ACCESSTOKEN_KEY DefaultValue:nil];
    if (accessToken == nil)
    {
        [MBProgressHUD showError:@"accessToken 为 nil"];
    }
    else
    {
         [self.btnUpload setEnabled:NO];
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:accessToken, @"access_token", nil];
        
        //这里只需要将一个名字为 "test.mp4"(demo中我已提供该视频) 的视频放置到Docunment文件夹根目录就行了。当然这只是个示例，你可以根据你的实际情况来确定视频放哪，一般视频都是下载的或者自己拍摄的。
        NSString *fileName = @"test.mp4";
        
        NSString *videoFilePath = [AndyUploadViewController getVideoFilePathWithFileName:fileName];
        
        NSDictionary *info = [AndyUploadViewController combineFileAttributesWithFilePath:videoFilePath];
        
        [[YoukuUploader sharedInstance] upload:params uploadInfo:info uploadDelegate:self dispatchQueue:nil];
    }
}

+ (NSDictionary *)combineFileAttributesWithFilePath:(NSString *)filePath
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    int fileSize = (int)dict[@"NSFileSize"];
    
    //视频名称
    [dictM setObject:@"这是测试知道吗" forKey:@"title"];
    //视频标签
    [dictM setObject:@"搞笑,综艺" forKey:@"tags"];
    [dictM setObject:filePath forKey:@"file_name"];
    //md5可以不传
    //[dictM setObject:@"sdfsfdsfs34758937458937" forKey:@"file_md5"];
    //文件大小
    [dictM setObject:@(fileSize) forKey:@"file_size"];
    
    return [dictM copy];
}

+ (NSString *)getVideoFilePathWithFileName:(NSString *)fileName
{
    NSString *videoDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                       inDomains:NSUserDomainMask] lastObject].path;
    
    NSString *videoPath = [NSString stringWithFormat:@"%@/%@",videoDirectory, fileName];
    
    return videoPath;
}


@end
