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
@property (nonatomic) NSData *imageData;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImageView];
}

- (void)initImageView
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(20, 55, 320, 350);
    self.imageView.backgroundColor = [UIColor greenColor];
    
   self.imageView.image = [UIImage imageWithData:self.imageData];
    [self.view addSubview:self.imageView];
}

- (void)downLoadImage
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *imageURL = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
    
    NSURLSessionTask *task = [session downloadTaskWithURL:imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        NSFileManager *file = [NSFileManager defaultManager];
        [file moveItemAtURL:location toURL:[NSURL URLWithString:imagePath] error:nil];
        self.imageData = [file contentsAtPath:imagePath];
    }];

    [task resume];
}



@end
