//
//  DownImage.h
//  DownLoadImage
//
//  Created by Jason on 17/11/30.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successDown)(id data);
typedef void(^failDown)(id error);

@interface DownImage : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic, copy)successDown _successBlock;
@property (nonatomic, copy)failDown _failBlock;
@property (nonatomic, strong)NSMutableData *_mutableData;

+ (void)downImage:(NSURL *)url successBlock:(successDown)successBlock fail:(failDown)failBlick;

- (void)startNSUrlConnection:(NSURL *)url ;

+ (void)startNSMutableRequest:(NSURL *)url;

+ (void)afNetWork:(successDown)_successBlock failDown:(failDown)_failBlock;

@end
