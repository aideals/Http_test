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
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8080/MJServer/resources/images/minion_01.png"];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"location = %@",location.path);
        
            //NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
            
            NSError *fileError;
            //NSFileManager *file = [NSFileManager defaultManager];
            //[file moveItemAtPath:location.path toPath:dataPath error:&fileError];
            //self.imageData = [file contentsAtPath:dataPath];
            //self.imageView.image = [UIImage imageWithData:self.imageData];
            NSFileManager *file = [NSFileManager defaultManager];
            self.imageData = [file contentsAtPath:location.path];
            self.imageView.image = [UIImage imageWithData:self.imageData];
            
            if (fileError == nil) {
                NSLog(@"save success");
            }
            else {
                NSLog(@"save error = %@",fileError);
            }
        } else {
            NSLog(@"downLoad error");
        }
    }];
    [task resume];
}



@end
