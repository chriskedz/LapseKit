//
//  EVLHTTPClient.m
//  LapseKit
//
//  Created by Caleb Davenport on 7/9/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import "EVLHTTPClient.h"

EVLHTTPClient *__sharedClient;

@implementation EVLHTTPClient {
    dispatch_queue_t _networkCallbackQueue;
}

#pragma mark - NSObject

- (id)init {
    NSURL *URL = [NSURL URLWithString:@"https://everlapse.com/api/v1"];
    self = [self initWithBaseURL:URL];
    return self;
}


#pragma mark - AFHTTPClient

- (id)initWithBaseURL:(NSURL *)URL {
    if ((self = [super initWithBaseURL:URL])) {
        _networkCallbackQueue = dispatch_queue_create("com.seesaw.everlapse.http-client.network-callback-queue", DISPATCH_QUEUE_SERIAL);
        [self setParameterEncoding:AFJSONParameterEncoding];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Accept-Encoding" value:@"gzip, deflate"];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return self;
}

- (void)enqueueHTTPRequestOperation:(AFHTTPRequestOperation *)operation {
    operation.successCallbackQueue = _networkCallbackQueue;
	operation.failureCallbackQueue = _networkCallbackQueue;
	[super enqueueHTTPRequestOperation:operation];
}


- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    [super getPath:path parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self handleError:error operation:operation failure:failure];
    }];
}


- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    [super postPath:path parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self handleError:error operation:operation failure:failure];
    }];
}


- (void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    [super deletePath:path parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self handleError:error operation:operation failure:failure];
    }];
}


- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    [super putPath:path parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self handleError:error operation:operation failure:failure];
    }];
}


- (void)patchPath:(NSString *)path parameters:(NSDictionary *)parameters success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    [super patchPath:path parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self handleError:error operation:operation failure:failure];
    }];
}


#pragma mark - Shared client

+ (instancetype)sharedClient {
    @synchronized(self) {
        if (__sharedClient == nil) {
            __sharedClient = [[self alloc] init];
        }
        return __sharedClient;
    }
}


+ (void)resetSharedClient {
    @synchronized(self) {
        [__sharedClient.operationQueue cancelAllOperations];
        __sharedClient = nil;
    }
}


#pragma mark - Error handling

- (void)handleError:(NSError *)error operation:(AFHTTPRequestOperation *)operation failure:(EVLHTTPClientFailure)failure {
#if DEBUG
    NSLog(@"Network request failed: %@ %@", operation.responseString, error);
#endif
    if ([operation.response statusCode] == 401) {
        [self handleUnauthorizedError:error operation:operation];
    }
    if (failure) {
        failure(operation, error);
    }
}


- (void)handleUnauthorizedError:(NSError *)error operation:(AFHTTPRequestOperation *)operation {
    
}


#pragma mark - Users

- (void)getUserWithID:(NSUInteger)userID success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    NSString *path = [NSString stringWithFormat:@"users/%@", @(userID)];
    [self getPath:path parameters:nil success:success failure:failure];
}


#pragma mark - Clips

- (void)getClipWithID:(NSUInteger)clipID success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    NSString *path = [NSString stringWithFormat:@"clips/%@", @(clipID)];
    [self getPath:path parameters:nil success:success failure:failure];
}


- (void)getClipWithSlug:(NSString *)slug success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    NSParameterAssert(slug != nil);
    NSString *path = [NSString stringWithFormat:@"clips/%@", slug];
    [self getPath:path parameters:@{ @"slug" : @YES } success:success failure:failure];
}


#pragma mark - Timelines

- (void)getClipsInTimelineWithName:(NSString *)timelineName success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    [self getClipsInTimelineWithName:timelineName beforeClipWithID:0 limit:0 success:success failure:failure];
}


- (void)getClipsInTimelineWithName:(NSString *)timelineName limit:(NSUInteger)limit success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    [self getClipsInTimelineWithName:timelineName beforeClipWithID:0 limit:limit success:success failure:failure];
}


- (void)getClipsInTimelineWithName:(NSString *)timelineName beforeClipWithID:(NSUInteger)clipID limit:(NSUInteger)limit success:(EVLHTTPClientSuccess)success failure:(EVLHTTPClientFailure)failure {
    NSParameterAssert(timelineName != nil);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (limit) {
        parameters[@"limit"] = @(limit);
    }
    if (clipID) {
        parameters[@"before_id"] = @(clipID);
    }
    [self getPath:timelineName parameters:parameters success:nil failure:nil];
}

@end
