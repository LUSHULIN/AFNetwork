//
//  DownImage.m
//  DownLoadImage
//
//  Created by Jason on 17/11/30.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "DownImage.h"
#import "AFNetworking.h"

#define URL @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1725523143,2463382781&fm=27&gp=0.jpg"

@implementation DownImage

+ (void)afNetWork:(successDown)_successBlock failDown:(failDown)_failBlock {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
//
//    AFURLSessionManager *sessionManger = [[AFURLSessionManager alloc] initWithSessionConfiguration:nil];
//    [sessionManger dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        
//    }];
    
    NSString *cerPath = [[NSBundle mainBundle]pathForResource:@"12306.cer" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:cerPath];
    NSSet *set = [[NSSet alloc] initWithObjects:data, nil];
    
    AFHTTPSessionManager *httpSession = [AFHTTPSessionManager manager];
    httpSession.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:set];
    httpSession.securityPolicy.allowInvalidCertificates = NO;
    httpSession.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    httpSession.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/jpeg"];

    [httpSession GET:URL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task:%@",task);
        NSData *data = (NSData *)responseObject;
        _successBlock(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _failBlock(error);
    }];
}

+ (void)downImage:(NSURL *)url successBlock:(successDown)successBlock fail:(failDown)failBlick {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        // 剪切文件
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
         NSData *data = [NSData dataWithContentsOfFile:path];
        if (error != nil) {
            failBlick(error);
        }else {
            successBlock(data);
        }
        
    }];
    [task resume];

}

- (void)startNSUrlConnection:(NSURL *)url {
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [__mutableData appendData:data];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"success");

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"fail");

}

+ (void)startNSMutableRequest:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
//    NSString *body = @"client=101&version=10.1.2";
//    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"data.length:%d",data.length);
    }];


}
@end
