//
//  BaseRequset.m
//  PinChaoPhone
//
//  Created by 旭朋  丁 on 15/8/27.
//  Copyright (c) 2015年 LSY. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

static BaseRequest* _instance;
static dispatch_once_t onceToken;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        _instance = [[BaseRequest alloc] init];
    });
    return _instance;
}

- (BOOL)beforeRequest:(AFHTTPRequestOperationManager *)manager {
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [SVProgressHUD showInfoWithStatus:@"请检查网络"];
                break;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    return true;
}

//Post
- (void)request:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    if (![self beforeRequest:manager]) {
        return;
    };
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBaseUrl,url];
    NSString *urlEncoded = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (!parameters) {
        parameters = [[NSDictionary alloc] init];
    }
    [parameters setValue:ppVersion forKey:@"version"];
    [parameters setValue:appbulid forKey:@"build"];
    NSMutableDictionary *completeParams = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//     NSLog(@"-------------url str:%@， params:%@", urlEncoded, completeParams);
    
    [manager POST:urlEncoded parameters:completeParams success:^(AFHTTPRequestOperation *operation, id responseData){
       // NSLog ( @"operation: %@" , operation. responseString );
        success(responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
           // NSLog ( @"operation: %@" , operation. responseString );
            failure(error);
        }
    }];
}

//Get
- (void)requestByGET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    if (![self beforeRequest:manager]) {
        return;
    };
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBaseUrl,url];
    NSString *urlEncoded = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (!parameters) {
        parameters = [[NSDictionary alloc] init];
    }
    NSMutableDictionary *completeParams = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [manager GET:urlEncoded parameters:completeParams success:^(AFHTTPRequestOperation *operation, id responseData){
        NSError *error;
        id responseObject = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        if (!error) {
            success(responseObject);
            }else{
//            NSLog(@" error %@", error.localizedDescription);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//Post
- (void) orderRequest:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    
    if (![self beforeRequest:manager]) {
        return;
    };
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kBaseUrl,url];
    NSString *urlEncoded = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (!parameters) {
        parameters = [[NSDictionary alloc] init];
    }
    [parameters setValue:ppVersion forKey:@"version"];
    [parameters setValue:appbulid forKey:@"build"];
    NSMutableDictionary *completeParams = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    NSLog(@"-------------url str:%@， params:%@", urlEncoded, completeParams);
    
    [manager POST:urlEncoded parameters:completeParams success:^(AFHTTPRequestOperation *operation, id responseData){
        
        success(responseData);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
