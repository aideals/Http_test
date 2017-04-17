//
//  ViewController.m
//  Http_test
//
//  Created by 鹏 刘 on 2017/4/12.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImageView];
    [self downLoadImage];
    
}

- (void)initImageView
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 55, 300, 450)];
    self.imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.imageView];
}


- (void)downLoadImage
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
 
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
     
        NSFileManager *file = [NSFileManager defaultManager];
        [file moveItemAtURL:location toURL:[NSURL URLWithString:imagePath] error:nil];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
            NSLog(@"imageView.image = %@",self.imageView.image);
                    });
        
    }];
    
    [task resume];
}



@end
